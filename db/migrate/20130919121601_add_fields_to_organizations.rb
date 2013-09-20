class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :address, :string
    add_column :organizations, :phone, :string
    add_column :organizations, :mail, :string
    add_column :organizations, :director_id, :integer

  end
end
