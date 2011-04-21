class Task < ActiveRecord::Base
  belongs_to :list
  validates :list, :title, :presence =>true
  validates :title, :length => { :maximum => 200 }
end
