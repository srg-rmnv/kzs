module UsersHelper
  
  def organzation_title(user)
    if user.organization_id?
  	  Organization.find(user.organization_id).title
  	else 
  		'-'
  	end
	end
  
end
