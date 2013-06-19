class ChangeUserOrganization < ActiveRecord::Migration
  def up
    remove_column :users, :organization
    add_column :users, :organization_id, :integer
  end

  def down
    remove_column :users, :organization_id
    add_column :users, :organization, :string
  end
end
