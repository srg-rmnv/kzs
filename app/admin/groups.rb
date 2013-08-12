ActiveAdmin.register Group do
  config.batch_actions = false
  config.clear_sidebar_sections!
  
   index do 
     column :id
     column :title
     default_actions
   end

   form do |f|  
     f.inputs t('properties') do
       f.input :title
       f.input :permissions, :as => :check_boxes
     end
     f.actions
   end

  show do |group|
    attributes_table do
      row :title
    end  
    
    panel t('permissions') do 
      table_for group.permissions do 
        column :title
        column :description
      end
    end
   end
end
