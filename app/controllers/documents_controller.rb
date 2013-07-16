class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json
  def index
    
    document = Document.order("created_at DESC")
    
    
    @documents = document.sent.where("recipient_id = ? OR approver_id = ?", current_user.id, current_user.id).all unless params[:type]
    
    if params[:type] == "inbox"
      @documents = document.sent.where("recipient_id = ? OR approver_id = ?", current_user.id, current_user.id).all
    elsif params[:type] == "draft"
      @documents = document.draft.where(:user_id => current_user.id).all
    elsif params[:type] == "sent"
      @documents = document.sent.where(:user_id => current_user.id).all  
    elsif params[:type] == "deleted"
      @documents = document.deleted.where(:user_id => current_user.id).all
    elsif params[:type] == "archived"
      @documents = document.archived.where(:user_id => current_user.id).all
    elsif params[:type] == "callback"
      @documents = document.callback.where(:user_id => current_user.id).all
    else
      @documents = document.sent.where("recipient_id = ? OR approver_id = ?", current_user.id, current_user.id).all
    end

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])
    
    if @document.user_id != current_user.id
      @document.opened = true
      @document.save
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])
    
    @document.user_id = current_user.id
    @document.organization_id = current_user.organization_id
    
    if params[:sent]
      @document.sent = true
    end
    

    respond_to do |format|
      if @document.save && 
        format.html { redirect_to documents_path, notice: t('document_successfully_created') }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])
    

    if params[:sent]
      @document.sent = true
    end   
    

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to documents_path, notice: t('document_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end
  
  def approve
    @document = Document.find(params[:id])
    @document.approved = true
    @document.save

    respond_to do |format|
      format.html { redirect_to documents_url, notice: t('document_approved_and_sent_to_recipient') }
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
end
