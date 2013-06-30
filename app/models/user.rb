class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  attr_accessible :name, :phone, :position, :organization_id, :division, :info,
                  :avatar, :dob, :permit, :work_status, :right_ids,
                  :email, :password, :password_confirmation, :remember_me,
                  :crop_x, :crop_y, :crop_w, :crop_h
                  
  has_many :user_rights
  has_many :rights, through: :user_rights
                              
  WORK_STATUSES = [ [I18n.t('at_work'), 'at_work'], [I18n.t('ooo'), 'ooo'] ]
  
  validates :name, :phone, :position, :organization_id, :division,
                   :email, :dob, :permit, :work_status, :presence => true
  validates :phone, :length => { :maximum => 11 }
  
  has_attached_file :avatar, :styles => { 
    :small => {:geometry => "100x100#", :processors => [:cropper]}, 
    :large => {:geometry => "500x500>"} 
  }
  
  after_update :reprocess_avatar, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  private
  
  def reprocess_avatar
      avatar.assign(avatar)
      avatar.save
    end
  
end