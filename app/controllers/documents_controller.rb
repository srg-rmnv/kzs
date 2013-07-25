class DocumentsController < ApplicationController
  
  # collection
  
  def index
    document = Document.not_deleted.not_archived.order("created_at DESC")
    organization = current_user.organization_id
    @documents = document.sent.where("organization_id = ?", organization).all unless params[:type]
    
    if params[:type] == "inbox"
      @documents = document.sent.where("organization_id = ?", organization).all
    elsif params[:type] == "prepared"
      @documents = document.prepared.where(:sender_organization_id => organization).all
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
    organization = current_user.organization_id
    document = Document.not_deleted.not_archived.order("created_at DESC")
    @documents = document.sent.where(:sender_organization_id => organization).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end
  
  def drafts
    document = Document.not_deleted.not_archived.order("created_at DESC")
    @documents = document.draft.where(:user_id => current_user.id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end
  
  def callbacks
    document = Document.not_deleted.not_archived.order("created_at DESC")
    @documents = document.callback.where(:user_id => current_user.id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end
  

  # member
  
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

  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create
    @document = Document.new(params[:document])
    
    @document.user_id = current_user.id
    @document.sender_organization_id = current_user.organization_id
    
    if params[:prepare]
      @document.prepared = true
      @document.draft = false
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
      @document.callback = false
    end   
    
    if params[:prepare]
      @document.prepared = true
      @document.draft = false
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
      format.html { redirect_to documents_url, notice: t('document_approved') }
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
end
