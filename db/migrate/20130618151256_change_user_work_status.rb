class ChangeUserWorkStatus < ActiveRecord::Migration
  def up
    remove_column :users, :work_status
    add_column :users, :work_status, :string
  end

  def down
    remove_column :users, :work_status
    add_column :users, :work_status, :integer
  end
end
