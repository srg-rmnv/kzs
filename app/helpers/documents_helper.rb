# coding: utf-8

module DocumentsHelper
  
  def doc_user(user_id)
    if User.exists?(user_id)
      User.find(user_id).first_name_with_last_name
    else
      "Deleted"
    end
  end
  
  def organization(organization_id)
    if Organization.exists?(organization_id)
      Organization.find(organization_id).title
    else
      "Deleted"
    end
  end   
  
  def indox(current_user)
    Document.sent.unopened.where(:organization_id => current_user.organization_id).count
  end
  
  def draft(current_user)
    Document.draft.where(:user_id => current_user.id).count
  end
  
  def to_be_approved(current_user)
    Document.prepared.not_approved.where(:approver_id => current_user.id).count
  end
  
  def to_be_sent(current_user)
    Document.prepared.approved.not_sent.where(:user_id => current_user.id).count
  end
  
  def for_approve(document)
    if document.approver_id == current_user.id && document.approved != true then true end
  end
  
  def for_send(document)
    if document.approver_id == current_user.id && document.sent != true && document.approved? || document.user_id == current_user.id && document.sent != true && document.approved? then true end
  end
  
  def for_callback(document)
    if document.user_id == current_user.id && document.opened != true && document.callback != true && document.sent == true then true end
  end
  
  def document_status(document)
    if document.opened?
      '<span class="label label-success">Прочитан</span>'.html_safe
    elsif document.sent?
       '<span class="label label-info">Не прочитан</span>'.html_safe
     elsif document.approved?
       '<span class="label label-warning">Подписан</span>'.html_safe    
     elsif document.prepared?
       '<span class="label">Подготовлен</span>'.html_safe
    elsif document.draft?
      '<span class="label label-inverse">Черновик</span>'.html_safe
    else
      nil
    end
  end
  
end
