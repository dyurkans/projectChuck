class Registration < ActiveRecord::Base
  attr_accessible :active, :date, :physical, :physical_date, :proof_of_insurance, :report_card, :student_id, :t_shirt_size, :team_id

  belongs_to :student
  belongs_to :team_id

  validates_numericality_of :student_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :team_id, :only_integer => true, :greater_than => 0
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  validates_date :date, :on_or_before => lambda { Date.current }, :on_or_before_message => "cannot be in the future"



end
