module OrganizationsHelper
  
  def possession(organization)
    if organization.parent_id? 
  	  Organization.find(organization.parent_id).title
  	else 
  		'-'
  	end
	end

  
end
