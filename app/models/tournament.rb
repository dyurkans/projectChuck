class Tournament < ActiveRecord::Base
  attr_accessible :end_date, :start_date

  has_many :brackets

  before_save :valid_dates

  validates_date :start_date, :message => "Must be a valid date"
  validates_date :end_date, :message => "Must be a valid date"
  #validate :valid_dates, :message => "End date must be later than start date"

  scope :by_date, order('start_date DESC, end_date DESC')

  #Humanize tournament name
  def name
  	"Project C.H.U.C.K. #{self.start_date.year}"
  end

  #make sure start and end dates are valid. Past dates are ok, if old data were to ever be entered.
  def valid_dates
  	self.end_date > self.start_date
  end

  #Total number of active students registered for the current tournament. 
  #Problems may arise if current tournament isn't most recent or if multiple tourns per year.
  def number_of_assigned_students
    total_number_of_assigned_students = 0
    brackets = Bracket.find_all_by_tournament_id(self.id)
    brackets.each do |bracket|
      total_number_of_assigned_students += bracket.current_number_of_students
    end
    total_number_of_assigned_students.zero? ? "---" : total_number_of_assigned_students
  end

end
