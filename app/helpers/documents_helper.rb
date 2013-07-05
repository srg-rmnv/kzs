module DocumentsHelper
  
  def doc_user(user_id)
    User.find(user_id).name
  end
  
  def organization(organization_id)
    Organization.find(organization_id).title
  end   
  
end
