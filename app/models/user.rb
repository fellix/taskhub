class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lists
  has_many :watches
  has_many :watched_lists, :class_name => "List" , :through => :watches, :source => :list
  validates :name, :presence => true, :length => { :maximum => 200 }
  mount_uploader :avatar, AvatarUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar

  def watched_lists_id
    watched_lists.map(&:id)
  end

  def to_s
    name
  end
end
