class User < ActiveRecord::Base
  attr_accessible :name, :phone, :position, :organization, :division, :info, :access_level,
                  :email, :photo, :dob, :permit, :work_status
                              
  WORK_STATUSES = [ [I18n.t('at_work'), 'at_work'], [I18n.t('ooo'), 'ooo'] ]
  
  has_attached_file :photo, :styles => { :thumb => "48x48#" }
  
end