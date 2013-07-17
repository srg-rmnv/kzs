class AlterUsersTable < ActiveRecord::Migration
  def up
    remove_column :users, :name
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :is_staff, :boolean
    add_column :users, :is_active, :boolean
    add_column :users, :is_superuser, :boolean
    add_column :users, :date_joined, :datetime   
  end

  def down
    add_column :users, :name, :string
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :is_staff
    remove_column :users, :is_active
    remove_column :users, :is_superuser
    remove_column :users, :date_joined
  end
end

