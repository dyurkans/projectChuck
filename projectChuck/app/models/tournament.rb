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
      return true
    else
      errors.add(:end_date, "End date must be later than the start date")
      return false
    end
  end

  def number_of_students
  	number_of_students = 0
  	@brackets = self.brackets
    @teams = []
    for bracket in @brackets
    	@teams << bracket.teams
    end
  	for team in @teams
  		for t in team
  			number_of_students += Registration.where(:team_id => t.id).size()
  		end
  	end
  	return number_of_students
  end
end
