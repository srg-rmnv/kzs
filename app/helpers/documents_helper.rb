module DocumentsHelper
  
  def doc_user(user_id)
    if User.exists?(user_id)
      User.find(user_id).name
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
    Document.sent.unopened.where(:recipient_id => current_user.id).count
  end
  
  def draft(current_user)
    Document.draft.where(:user_id => current_user.id).count
  end
  
  def to_be_approved(current_user)
    Document.sent.not_approved.where(:approver_id => current_user.id).count
  end
  
  def for_approve(document)
    if document.approver_id == current_user.id && document.approved != true then true end
  end
  
end
