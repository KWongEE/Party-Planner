class InviteList < ActiveRecord::Base
  belongs_to :parties
  belongs_to :friends
end
