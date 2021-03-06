class DocumentsController < ApplicationController
  helper_method :sort_column, :sort_direction
  # collection
  
  def index
    # check if user can view confindetnial documents
    if current_user.has_permission?(5)
      documents = Document.all
    else
      documents = Document.not_confidential
    end
    organization = current_user.organization_id
    
    #default scope
    if params[:status_sort]
      direction = params[:direction]
      sort_type = "opened #{direction}", "sent #{direction}", "approved #{direction}", "prepared #{direction}"
    else
      sort_type = sort_column + " " + sort_direction
    end
    
    documents = Document.text_search(params[:query]).not_deleted.not_archived.order(sort_type).where{(sent == true) & (organization_id == organization) | (draft == false) & (sender_organization_id == organization)}
    
    # mails
    if params[:type] == "mails"
      @documents = documents.where(:document_type => 'mail')
      
    # writs
    elsif params[:type] == "writs"
      @documents = documents.where(:document_type => 'writ')
      
    # any other case
    else
      @documents = documents
    end  
    
    @documents = @documents.paginate(:per_page => 20, :page => params[:page])
    
    respond_to do |format|
      format.html
      format.js
    end
    
  end
  
  def drafts    
    @documents = Document.not_deleted.not_archived.order("created_at DESC").draft.where(:user_id => current_user.id)
    @documents = @documents.paginate(:per_page => 20, :page => params[:page])
  end
  
  def batch
    documents_ids = params[:document_ids]
    if params[:prepare]
      Document.update_all({prepared: true, draft: false}, {id: documents_ids})
    elsif params[:approve]
      Document.where(:id => documents_ids).each do |d|
        d.draft = false
        d.approved = true
        d.approved_date = Time.now
        d.date = Time.now
        d.sn = "D" + d.id.to_s
        d.save!
      end
    elsif params[:send]
        Document.update_all({sent: true, sent_date: Time.now}, {id: documents_ids})
    end
    redirect_to documents_path, notice: t('documents_updated')
  end
  
  # member
  
  def show
    @document = Document.find(params[:id])
    if DocumentConversation.exists?(@document.document_conversation_id)
      @conversation = DocumentConversation.find(@document.document_conversation_id)
      @conversation_documents = @conversation.documents.where('id != ?', @document.id)
    end
    
    if current_user.permissions.exists?('1') && @document.organization_id == current_user.organization_id && @document.opened != true
      @document.opened = true
      @document.save
      users = User.where(:organization_id => @document.sender_organization_id)
      users.each do |user|
        OpenNotice.create!(:user_id => user.id, :document_id => @document.id)
      end
    end
    
    @sender_organization = Organization.find(@document.sender_organization_id).title
    @organization = Organization.find(@document.organization_id).title
    @sender = User.find(@document.user_id).first_name_with_last_name
    @executor = User.find(@document.executor_id).first_name_with_last_name

    respond_to do |format|
      format.html # show.html.erb
      format.json {render :json => {:sender_organization => @sender_organization, 
                                    :sender_organization_id => @sender_organization_id,
                                    :organization => @organization,
                                    :organization_id => @organization_id,
                                    :title => @document.title,
                                    :sn => @document.sn,
                                    :date => @document.date,
                                    :type => t(@document.document_type),
                                    :executor => @executor,
                                    :sender => @sender,
                                    :prepared => @document.prepared,
                                    :prepared_date => @document.prepared_date,
                                    :approved => @document.approved,
                                    :approved_date => @document.approved_date,
                                    :sent => @document.sent,
                                    :sent_date => @document.sent_date,
                                    :opened => @document.opened,
                                    :opened_date => @document.opened_date,
                                    :attachments => @document.document_attachments,
                                    :conversation => @conversation }}
      format.pdf do
        pdf = DocumentPdf.new(@document, view_context)
        send_data pdf.render, filename: "document_#{@document.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def new
    @document = Document.new
    @approvers = User.approvers.where("organization_id = ?", current_user.organization_id)
    @executors = User.where(:organization_id => current_user.organization_id)
    @recipients = User.where('organization_id != ?', current_user.organization_id)
    @documents = Document.all
  end

  def edit
    @document = Document.find(params[:id])
    @approvers = User.approvers.where("organization_id = ?", current_user.organization_id)
    @executors = User.where(:organization_id => current_user.organization_id)
    @recipients = User.where('organization_id != ?', current_user.organization_id)
    @documents = Document.where('id != ?', @document.id)
    
    if @document.user_id != current_user.id && @document.approver_id != current_user.id
      redirect_to :back, :alert => t('access_denied')
    elsif @document.approved
      redirect_to :back, :alert => t('approved_document_couldnt_be_edited')
    end
    
      
  end

  def create
    organizations = params[:document][:organization_ids]
    organizations = organizations.delete_if{ |x| x.empty? }
    organizations.each do |organization|
      document = Document.new(params[:document])
      document.organization_id = organization
      document.user_id = current_user.id
      document.sender_organization_id = current_user.organization_id
      if params[:prepare]
        document.prepared = true
        document.draft = false
      end
      document.save!
    end
    redirect_to documents_path, notice: t('document_successfully_created')
  end

  def update
    @document = Document.find(params[:id])
    @document.user_id = current_user.id
    
    if params[:prepare]
      @document.prepared = true
      @document.draft = false
    end
    
    if params[:to_draft]
      @document.prepared = false
      @document.draft = true
    end
    
    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to document_path(@document), notice: t('document_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def prepare
    @document = Document.find(params[:id])
    @document.prepared = true
    @document.draft = false
    @document.save
    redirect_to documents_url, notice: t('document_prepared')
  end
  
  def approve
    @document = Document.find(params[:id])
    
    if current_user.id == @document.approver_id    
      @document.draft = false
      @document.approved = true
      @document.approved_date = Time.now
      @document.date = Time.now
      @document.sn = "D" + @document.id.to_s
      @document.save
      redirect_to documents_path, notice: t('document_approved')
    else
      redirect_to :back, notice: t('permission_denied')
    end
  end
  
  def send_document
    @document = Document.find(params[:id])
    @document.sent = true
    @document.save
    redirect_to documents_url, notice: t('document_successfully_sent')
  end
  
  def callback
    @document = Document.find(params[:id])
    @document.sent = false
    @document.callback = true
    @document.save
    redirect_to documents_url, notice: t('document_called_back')
  end
  
  def execute
    @document = Document.find(params[:id])
    @document.for_confirmation = true
    @document.save    

    respond_to do |format|
      format.html 
      format.json 
    end
  end
  
  
  def archive
    @document = Document.find(params[:id])
    @document.archived = true
    @document.save
    redirect_to :back, notice: t('document_archived')
  end
  
  def delete
    @document = Document.find(params[:id])
    if @document.draft?
      @document.destroy
    else
      @document.deleted = true
      @document.save
    end
    
    redirect_to documents_path, notice: t('document_deleted')
  end
  
  def copy
    @original_document = Document.find(params[:id]) # find original object
    @document = Document.new(:organization_id => @original_document.organization_id,
                             :approver_id => @original_document.approver_id,
                             :executor_id => @original_document.executor_id,
                             :title => @original_document.title,
                             :text => @original_document.text,
                             :document_type => @original_document.document_type,
                             :document_attachments => @original_document.document_attachments,
                             :document_ids => @original_document.document_ids)
    @approvers = User.approvers.where("organization_id = ? AND users.id != ?", current_user.organization_id, current_user.id)
    @executors = User.where(:organization_id => current_user.organization_id)
    @recipients = User.where('organization_id != ?', current_user.organization_id)
    @documents = Document.all
    render :new # render same view as "new", but with @prescription attributes already filled in
  end
  
  def reply
    @original_document = Document.find(params[:id])
    @document_conversation_id = DocumentConversation.where(:id => @original_document.document_conversation_id).first_or_create!
    @document_conversation_id = @document_conversation_id.id
    @original_document.document_conversation_id = @document_conversation_id
    @original_document.save!
    @document = Document.new
    @document_conversation_id
    @approvers = User.approvers.where("organization_id = ?", current_user.organization_id)
    @executors = User.where(:organization_id => current_user.organization_id)
    @recipients = User.where('organization_id != ?', current_user.organization_id)
    @documents = Document.all
    
    if current_user.organization_id != @original_document.sender_organization_id && @original_document.opened?
      render :new
    else
      redirect_to :back, :alert => t('only_mails_from_other_organizations_could_be_answered')
    end
      
  end
  
  def to_drafts
    @document = Document.find(params[:id])
    @document.prepared = false
    @document.draft = true
    @document.user_id = current_user.id
    @document.save
    redirect_to documents_url, notice: t('document_prepared')
  end
  
  # misc
  
  def executor_phone
      @user = User.find(params[:user])
      respond_to do |format|
         format.js {  }
      end
  end
  
  private
  
  def sort_column
    Document.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  def check_edit_permission
  end
  
  
end
