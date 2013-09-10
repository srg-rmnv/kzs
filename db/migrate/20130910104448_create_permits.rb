class CreatePermits < ActiveRecord::Migration
  def change
    create_table :permits do |t|
      t.string :number
      t.integer :user_id
      t.string :purpose
      t.date :start_date
      t.date :expiration_date
      t.string :requested_duration
      t.string :granted_area
      t.string :granted_object
      t.string :permit_type
      t.boolean :agreed, :default => false
      t.boolean :canceled, :default => false
      t.boolean :released, :default => false
      t.boolean :issued, :default => false

      t.timestamps
    end
  end
end
