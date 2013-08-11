ActiveAdmin.register Permission do
  config.batch_actions = false
  config.clear_sidebar_sections!
  actions :index, :show
  
   index do 
     column :id
     column :title
     column :description
     default_actions
   end

   form do |f|  
     f.inputs t('properties') do
       f.input :title
     end
     f.actions
   end

  show do
    attributes_table do
      row :title
    end  
   end
end
