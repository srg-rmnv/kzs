class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.string   :title
      t.integer  :user_id
      t.integer  :sender_organization_id
      t.integer  :organization_id
      t.integer  :document_id
      t.text     :text
      t.attachment :file
      t.boolean  :draft,                  :default => true
      t.boolean  :prepared,               :default => false
      t.boolean  :opened,                 :default => false      
      t.boolean  :accepted,               :default => false
      t.boolean  :not_accepted,           :default => false
      t.boolean  :sent,                   :default => false
      t.boolean  :deleted,                :default => false

      


      t.timestamps
    end
  end
end
