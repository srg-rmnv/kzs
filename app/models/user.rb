class User < ActiveRecord::Base
  attr_accessible :name, :phone, :position, :organization, :division, :info, :access_level,
                  :email, :photo, :dob, :permit, :work_status
end