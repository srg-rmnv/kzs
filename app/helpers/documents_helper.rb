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
  
end