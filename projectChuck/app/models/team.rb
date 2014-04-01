class Team < ActiveRecord::Base
  attr_accessible :bracket_id, :max_students, :name
  
  belongs_to :bracket
  has_many :registrations
  has_many :students, :through => :registrations

end
