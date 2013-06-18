class User < ActiveRecord::Base
  attr_accessible :name, :phone, :position, :organization, :division, :info, :access_level,
                  :email, :photo, :dob, :permit, :work_status
                              
  WORK_STATUSES = [ [I18n.t('at_work'), 'at_work'], [I18n.t('ooo'), 'ooo'] ]
  
  ACCESS_LEVELS = [ [I18n.t('level1'), 'level1'], [I18n.t('level2'), 'level2'], [I18n.t('level3'), 'level3'] ]
  
  has_attached_file :photo, :styles => { :thumb => "48x48#" }
  
  validates :name, :phone, :position, :organization, :division, :info, :access_level,
                   :email, :photo, :dob, :permit, :work_status, :presence => true
  validates :phone, :length => { :maximum => 11 }
  
  
end