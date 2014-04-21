class Bracket < ActiveRecord::Base
  attr_accessible :gender, :max_age, :min_age, :tournament_id

  has_many :teams
  belongs_to :tournament

  GENDER_LIST = [["Male", true], ["Female", false]]

  validates_numericality_of :tournament_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :min_age, :only_integer => true, :greater_than_or_equal_to => 7 
  validates_numericality_of :max_age, :only_integer => true, :less_than_or_equal_to => 18
  validates_inclusion_of :gender, :in => [true, false], :message => "must be true or false"

  scope :by_gender, order('gender')
  scope :by_age, order('min_age, max_age')

  def sex
    return "Male" if gender == true
    "Female"
  end

  def gender_name
    GENDER_LIST.map{|genders| genders[1] == gender}
  end

  def name
  	"#{self.sex} #{self.min_age} - #{self.max_age}"
  end

  def waitlist
    spots = 0
    for t in self.teams
      if t.remaining_spots > 0
        spots += t.remaining_spots
      end
    end
    if spots > 0 
      return spots
    else
      return 0
    end
  end

  def eligible_students(min,max)
    unassigned_regs = Registration.current.active.by_date.select { |reg| reg.team_id == nil }
    eligible_regs = []
    for reg in unassigned_regs 
      if Student.find(reg.student_id).age_as_of_june_1 >= min and Student.find(reg.student_id).age_as_of_june_1 <= max
        eligible_regs << Student.find(reg.student_id)
      end
    end
    eligible_regs
  end
end