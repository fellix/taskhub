class List < ActiveRecord::Base
  has_many :tasks
  belongs_to :user
  validates :user, :presence => true
  validates :name, :presence => true, :length => { :maximum => 200 }
end
