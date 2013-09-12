class AddRejectedToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :rejected, :boolean, :default => false
  end
end
