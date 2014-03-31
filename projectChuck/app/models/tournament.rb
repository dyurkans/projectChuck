class Tournament < ActiveRecord::Base
  attr_accessible :end_date, :start_date
  has_many :brackets
end
