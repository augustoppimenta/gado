class Row < ActiveRecord::Base
  belongs_to :user
  belongs_to :race
  acts_as_votable 
end
