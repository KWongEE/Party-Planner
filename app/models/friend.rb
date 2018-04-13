class Friend < ActiveRecord::Base
  has_many :invite_lists
  has_many :parties, through: :invite_lists
  validates :first_name, presence: true
  validates :last_name, presence: true
end
