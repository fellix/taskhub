# encoding: utf-8
class List < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  belongs_to :user
  validates :user, :presence => true
  validates :name, :presence => true, :length => { :maximum => 200 }
  accepts_nested_attributes_for :tasks, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

  def self.lists_by_user(user_id)
    where(:user_id => user_id)
  end

  def status
    public ? "Pública" : "Privada"
  end

  def can_access?(user_id)
    return true if public
    user.id == user_id
  end

  def can_watch?(user_id)
    current_user = User.find(user_id)
    self.user != current_user && !current_user.watched_lists_id.include?(self.id)
  end

  def user_name
    user.name
  end
end
