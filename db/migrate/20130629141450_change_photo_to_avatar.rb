class ChangePhotoToAvatar < ActiveRecord::Migration
  def self.up
    remove_attachment :users, :photo
    add_attachment :users, :avatar
  end

  def self.down
    remove_attachment :users, :avatar
    add_attachment :users, :photo
  end
end
