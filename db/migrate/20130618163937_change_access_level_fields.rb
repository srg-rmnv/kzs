class ChangeAccessLevelFields < ActiveRecord::Migration
  def up
    remove_column :users, :access_level
    add_column :users, :access_level, :string
  end

  def down
    remove_column :users, :access_level
    add_column :users, :access_level, :integer
  end
end
