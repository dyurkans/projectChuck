class Bracket < ActiveRecord::Base
  attr_accessible :gender, :max_age, :min_age, :tournament_id

  has_many :teams
  belongs_to :tournament

  GENDER_LIST = [["Male", true], ["Female", false]]

  validates_numericality_of :tournament_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :min_age, :only_integer => true
  validates_numericality_of :max_age, :only_integer => true
  validates_inclusion_of :gender, :in => [true, false], :message => "Must be true or false"
  validate :valid_age_limits, :message => "Min age must be at least 7. Max age must be no greater than 18. Min age can't be larger than max age."

  scope :by_gender, order('gender')
  scope :by_age, order('brackets.max_age')

  #restricts valid max and min bracket ages and ensures max is never less than min
  def valid_age_limits
    unless self.min_age.nil? || self.max_age.nil?  
      return ((self.min_age >= 7) && (self.max_age <= 18))
    else
      false
    end 
  end

  #Humanized bracket gender
  def sex
    if gender == true then "Male" else "Female" end
  end

  #humanized bracket name
  def name
  	"#{self.sex} #{self.min_age} - #{self.max_age}"
  end

  #num of spots available in all teams in bracket. Used for waitlist.
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

  #Use this to produce the total number of students assigned to teams on a specific bracket
  def current_number_of_students
    total_number_of_students = 0
    if not self.teams.nil?
      self.teams.each do |team|
        total_number_of_students += team.current_number_of_students
      end
    end
    total_number_of_students
  end
  
  #Use the eligible_students method to produce a 
  #list of eligible unassigned students for a specific bracket
  def eligible_students
    min = self.min_age
    max = self.max_age
    Student.current.unassigned.select { |stu| stu.gender == self.gender and stu.age_as_of_june_1 >= min and stu.age_as_of_june_1 <= max}
  end

  #Use this to produce a list of eligible students given an age range, but without regards to gender
  #Not currently used anywhere
  def old_all_eligible_students
    Student.current.active.ages_between(self.min_age, self.max_age)
  end
  
  #This produces a list of all eligible students, both assigned and unassigned
  def all_eligible_students
    if self.gender == true
      Student.current.male.active.ages_between(self.min_age, self.max_age)
    else
      Student.current.female.active.ages_between(self.min_age, self.max_age)
    end
  end

end