class Party < ActiveRecord::Base
has_many :invite_lists
has_many :friends, through: :invite_lists

validates :name, presence: true
validates :location, presence: true
validates :description, presence: true
end
