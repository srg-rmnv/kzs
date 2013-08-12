ActiveAdmin.register User do
  config.batch_actions = false
  filter :username
  
   index do 
     column :id
     column :username
     column :first_name
     column :last_name

     default_actions



   end

   form do |f|  
     f.inputs t('properties') do
       f.input :username
       f.input :first_name
       f.input :last_name
       f.input :phone
       f.input :position
       f.input :division
       f.input :dob
       f.input :avatar
       f.input :email
       f.input :organization_id, :as => :select, :collection => Organization.all
       f.input :work_status, :as => :select, :collection => User::WORK_STATUSES.map { |a| [ t(a), a ] }, :include_blank => false
       f.input :password
       f.input :password_confirmation
       f.input :permissions, :as => :check_boxes
       
     end
     f.actions
   end

  show do
    attributes_table do
      row :username
      row :phone
      row :position
      row :division
      row :dob
      row :date_joined
      row :is_superuser
      row :is_staff
      row :first_name
      row :last_name
      row :avatar
      row :permit
      row :current_sign_in_ip
      row :last_sign_in_at
      row :sign_in_count
      row :email
      row :organization_id
      row :work_status do |row|
        I18n.t(row.work_status)
      end
      row :created_at
    end  
   end
   
   controller do
     def update
         if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
             params[:user].delete(:password)
             params[:user].delete(:password_confirmation)
         end
         super
     end 
   end
end
