class Registration < ActiveRecord::Base
  attr_accessible :active, :date, :physical, :physical_date, :proof_of_insurance, :report_card, :student_id, :t_shirt_size, :team_id

  belongs_to :student
  belongs_to :team

  validates_numericality_of :student_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :team_id, :only_integer => true, :greater_than => 0
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  validates_date :date, :on_or_before => lambda { Date.current }, :on_or_before_message => "cannot be in the future"

  #insert age as of june 1 method
  def age_as_of_june_1
  	return nil if self.student.dob.blank?
  	(Date.new(self.date.year, 6, 1).to_time.to_s(:number).to_i - self.student.dob.to_time.to_s(:number).to_i)/10e9.to_i
  end

end
