class Team < ActiveRecord::Base
  attr_accessible :bracket_id, :max_students, :name
  
  has_many :students, :through => :registrations
  belongs_to :bracket
  
end
