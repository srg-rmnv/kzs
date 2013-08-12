ActiveAdmin.register Organization do
    config.batch_actions = false
    filter :username
    config.sort_order = "id_asc"

     index do 
       column :id
       column :title
       column :parent_id do |column|
         if Organization.exists?(column.parent_id)
           Organization.find(column.parent_id).title
         end
       end
       default_actions
     end

     form do |f|  
       f.inputs t('properties') do
         f.input :title
         f.input :parent_id, :as => :select, :collection => Organization.all
       end
       f.actions
     end

    show do
      attributes_table do
        row :title
        row :parent_id
      end  
     end
end
