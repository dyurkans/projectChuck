class Bracket < ActiveRecord::Base
  attr_accessible :gender, :max_age, :min_age, :tournament_id

  has_many :teams
  belongs_to :tournament

  GENDER_LIST = [["Male", true], ["Female", false]]

  validates_numericality_of :tournament_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :min_age, :only_integer => true, :greater_than_or_equal_to => 7, :less_than_or_equal_to => :max_age 
  validates_numericality_of :max_age, :only_integer => true, :less_than_or_equal_to => 18
  validates_inclusion_of :gender, :in => [true, false], :message => "Must be true or false"

  scope :by_gender, order('gender')
  scope :by_age, order('min_age, max_age')

  def sex
    if gender == true then "Male" else "Female" end
  end

  def name
  	"#{self.sex} #{self.min_age} - #{self.max_age}"
  end

  def remaining_spots
    spots = 0
    for t in self.teams
      if t.remaining_spots > 0
        spots += t.remaining_spots
      end
    end
    if spots > 0 
      spots
    else
      0
    end
  end

  def current_number_of_students
    total_number_of_students = 0
    if not self.teams.nil?
      self.teams.each do |team|
        total_number_of_students += team.current_number_of_students
      end
    end
    total_number_of_students
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

  def all_eligible_students
    current_regs = Registration.current.active.by_date
    active_students = Student.active
    eligible_regs = []
    for reg in current_regs 
      if active_students.find(reg.student_id).age_as_of_june_1 >= self.min_age and active_students.find(reg.student_id).age_as_of_june_1 <= self.max_age
        eligible_regs << Student.find(reg.student_id)
      end
    end
    eligible_regs
  end

end