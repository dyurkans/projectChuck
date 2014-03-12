class Registration < ActiveRecord::Base
  attr_accessible :active, :date, :physical, :physical_date, :proof_of_insurance, :report_card, :student_id, :t_shirt_size, :team_id
end
