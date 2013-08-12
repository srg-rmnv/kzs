class CreatePermissionGroups < ActiveRecord::Migration
  def change
    create_table :permission_groups do |t|
      t.integer :permission_id
      t.integer :group_id

      t.timestamps
    end
  end
end
