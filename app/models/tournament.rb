class Tournament < ActiveRecord::Base
  attr_accessible :end_date, :start_date

  has_many :brackets

  before_save :valid_dates

  validates_date :start_date, :message => "Must be a valid date"
  validates_date :end_date, :message => "Must be a valid date"
  validate :valid_dates, :message => "End date must be later than start date"

  scope :by_date, order('start_date DESC')

  def name
  	"Project C.H.U.C.K. #{self.start_date.year}"
  end


  def valid_dates
  	if self.end_date > self.start_date
      true
    else
      errors.add(:end_date, "End date must be later than the start date")
      false
    end
  end

  def number_of_students
    total_number_of_students = 0
    brackets = Bracket.find_all_by_tournament_id(self.id)
    brackets.each do |bracket|
      total_number_of_students += bracket.current_number_of_students
    end
    total_number_of_students.zero? ? "---" : total_number_of_students
  end
    
end
