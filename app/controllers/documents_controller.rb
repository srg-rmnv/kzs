class DocumentsController < ApplicationController
  
  # collection
  
  def index
    
    
    
    if current_user.has_permission?(5)
      document = Document.not_deleted.not_archived.order("created_at DESC")
    else
      document = Document.not_deleted.not_archived.not_confidential.order("created_at DESC")
    end
    
    organization = current_user.organization_id
    @documents = document.sent.where(:organization_id => organization).all unless params[:type]
    
    if params[:type] == "inbox"
      @documents = document.sent.where(:organization_id => organization).all
    elsif params[:type] == "prepared"
      @documents = document.prepared.not_sent.where(:sender_organization_id => organization).all
    elsif params[:type] == "approved"
      @documents = document.approved.where(:sender_organization_id => organization).all
    elsif params[:type] == "archived"
      @documents = Document.order("created_at DESC").not_deleted.archived.where(:user_id => current_user.id).all
    elsif params[:type] == "deleted"
      @documents = Document.order("created_at DESC").deleted.where(:user_id => current_user.id).all

    else
      @documents = document.sent.where("organization_id = ?", organization).all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  def sents
    
    if current_user.has_permission?(5)
      document = Document.not_deleted.not_archived.order("created_at DESC")
    else
      document = Document.not_deleted.not_archived.not_confidential.order("created_at DESC")
    end
    
    organization = current_user.organization_id
    @documents = document.sent.where(:sender_organization_id => organization).all
    
    current_user.open_notices.destroy_all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end
  
  def drafts
    
    if current_user.has_permission?(5)
      document = Document.not_deleted.not_archived.order("created_at DESC")
    else
      document = Document.not_deleted.not_archived.not_confidential.order("created_at DESC")
    end
    
    @documents = document.draft.where(:user_id => current_user.id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end
  
  def callbacks
    
    if current_user.has_permission?(5)
      document = Document.not_deleted.not_archived.order("created_at DESC")
    else
      document = Document.not_deleted.not_archived.not_confidential.order("created_at DESC")
    end
    
    @documents = document.callback.where(:user_id => current_user.id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end
  

  # member
  
  def show
    @document = Document.find(params[:id])
    
    if current_user.permissions.exists?('1') && @document.organization_id == current_user.organization_id && @document.opened != true
      @document.opened = true
      @document.save
      users = User.where(:organization_id => @document.sender_organization_id)
      users.each do |user|
        OpenNotice.create!(:user_id => user.id, :document_id => @document.id)
      end
    end

    respond_to do |format|
      format.html # show.html.erb
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
    @approvers = User.approvers.where("organization_id = ? AND users.id != ?", current_user.organization_id, current_user.id)
    @executors = User.where(:organization_id => current_user.organization_id)
    @recipients = User.where('organization_id != ?', current_user.organization_id)
    @documents = Document.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  def edit
    @document = Document.find(params[:id])
    @approvers = User.approvers.where("organization_id = ? AND users.id != ?", current_user.organization_id, current_user.id)
    @executors = User.where(:organization_id => current_user.organization_id)
    @recipients = User.where('organization_id != ?', current_user.organization_id)
    @documents = Document.where('id != ?', @document.id)
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

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])
    

    if params[:sent]
      @document.sent = true
      @document.callback = false
    end   
    
    if params[:prepare]
      @document.prepared = true
      @document.draft = false
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

    respond_to do |format|
      format.html { redirect_to documents_url, notice: t('document_prepared') }
      format.json { head :no_content }
    end
  end
  
  def approve
    @document = Document.find(params[:id])
    @document.draft = false
    @document.approved = true
    @document.save

    respond_to do |format|
      format.html { redirect_to document_path(@document), notice: t('document_approved') }
      format.json { head :no_content }
    end
  end
  
  def send_document
    @document = Document.find(params[:id])
    @document.sent = true
    @document.save
  
    respond_to do |format|
      format.html { redirect_to documents_url, notice: t('document_successfully_sent') }
      format.json { head :no_content }
    end
  end
  
  def callback
    @document = Document.find(params[:id])
    @document.sent = false
    @document.callback = true
    @document.save

    respond_to do |format|
      format.html { redirect_to documents_url, notice: t('document_called_back') }
      format.json { head :no_content }
    end
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

    respond_to do |format|
      format.html { redirect_to :back, notice: t('document_archived') }
      format.json { head :no_content }
    end
  end
  
  def delete
    @document = Document.find(params[:id])
    @document.deleted = true
    @document.save

    respond_to do |format|
      format.html { redirect_to documents_path, notice: t('document_deleted') }
      format.json { head :no_content }
    end
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
  
  # misc
  
  def executor_phone
      @user = User.find(params[:user])
      respond_to do |format|
         format.js {  }
      end
  end
  
  
end
