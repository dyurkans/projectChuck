class Student < ActiveRecord::Base
  attr_accessible :active, :allergies, :birth_certificate, :cell_phone, :dob, :emergency_contact_name, :emergency_contact_phone, :first_name, :gender, :grade_integer, :household_id, :last_name, :medications, :school, :school_county, :security_question, :security_response

  # Relationships
  belongs_to :household
  has_many :registrations
  has_many :guardians, through: :household

  #Callbacks
  before_save :reformat_cell
  before_save :reformat_emergency_phone
  before_destroy :check_if_destroyable
  after_rollback :deactivate_student_and_registrations, :on => :destory


  #Validations (email commented out b/c not in the database)
  validates_presence_of :first_name, :last_name, :emergency_contact_name, :school, :school_county, :security_response, :security_question, :grade_integer
  validates_date :dob, :on_or_before => 7.years.ago.to_date, :after => 19.years.ago.to_date, :message => "must be between the ages of 7 and 18 included"  # Documentation didn't show proper syntax for  between message. #:on_or_before_message => "must 
  validates_format_of :cell_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only", :allow_blank => true, :allow_nil => true
  validates_format_of :emergency_contact_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  # validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
  validates_inclusion_of :gender, :in => [true, false], :message => "must be true or false"
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  #validates_inclusion_of :security_question, :in => SECURITY_QUESTIONS.map() #Need to check how mapping works
  #validates_inclusion_of :security_response, :in => SECURITY_RESPONSES.map() #Need to check how mapping works
  #Add these tests to student_test file
  validates_numericality_of :household_id, :only_integer => true, :greater_than => 0, :allow_nil => true
  validates_numericality_of :grade_integer, :only_integer => true, :greater_than => 0, :less_than => 14

  #security questions: "What was the name of your first pet", ""
  SECURITY_QUESTIONS = [["What was the name of your first pet?",0], ["What is your mother's maiden name?",1],
                        ["What was the name of your first church?",2]]
  
  GENDER_LIST = [["Male", true], ["Female", false]]
  GRADES_LIST = [["First",1],["Second",2], ["Third",3],["Fourth",4],["Fifth",5],["Sixth",6],["Seventh",7],["Eigth",8],
                 ["Freshman",9],["Sophomore",10],["Junior",11],["Senior",12],["Graduated Senior",13]]

  # Scopes
  scope :alphabetical, order('last_name, first_name')
  scope :by_age, order('dob DESC')
  scope :male, where('students.gender = ?', true)
  scope :female, where('students.gender = ?', false)
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :by_grade, order('grade_integer')
  scope :grade, lambda {|grade_integer| where("grade_integer = ?", grade_integer)}
  scope :by_school, order('school')
  scope :by_county, order('school_county')
  scope :has_allergies, where('allergies <> ""')
  scope :needs_medication, where('medications <> ""')
  scope :seniors, where('grade_integer = ?', 13)
  scope :missing_birth_certificate, where('birth_certificate = ? ', nil)
  scope :without_forms, joins(:registrations).where('birth_certificate = ? || physical = ? || proof_of_insurance = ? || report_card = ?', nil,nil,nil,nil)



  # Other methods
  # def eligible_students(bracket_id,team_id)
  #   bracket = Bracket.find(bracket_id)
  #   min_age =  bracket.min_age
  #   max_age = bracker.max_age
  #   team_gender = Team.find(team_id).gender
  #   registered_students = Student.active.where(self.registrations.reg_order[0].active = true unless self.registrations.nil? )
  #   eligible_students = registered_students.select { |s| s.age_as_of_june_1 >= min_age and s.age_as_of_june_1 <= max_age and s.gender = team_gender }
  # end
  def check_if_destroyable
    return false
  end

  def deactivate_student_and_registrations
    self.active = false
    self.save! 
    unless self.registrations.nil? || self.registrations.empty?
      for reg in self.registrations.active
        reg.active = false
        reg.save!
      end      
    end
  end
  
  def missing_report_card
    self.registrations.reg_order[0].report_card.nil? unless (self.registrations.nil? || self.registrations.empty?)
  end

  #Currently not in use/ or not functioning. Replaced by eligible_students method in team.rb
  def self.ages_between(low_age,high_age)
    Student.where("dob between ? and ?", ((high_age+1).years - 1.day).ago.to_date, low_age.years.ago.to_date)
  end

  def self.qualifies_for_bracket(bracket_id)
    bracket = Bracket.find(bracket_id)
    if (bracket.gender)
      Student.ages_between(bracket.min_age, bracket.max_age).male
    else
      Student.ages_between(bracket.min_age, bracket.max_age).female
    end
  end

  def self.qualifies_for_team(team_id)
    self.qualifies_for_bracket(Team.find(team_id).bracket_id)
  end

  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end

  def age
    return nil if dob.blank?
    (Time.now.to_s(:number).to_i - dob.to_time.to_s(:number).to_i)/10e9.to_i
  end

  def sex
    return "Male" if gender == true
    "Female"
  end

  def gender_name
    GENDER_LIST.map{|genders| genders[1] == gender}
  end

  # Method to find student's registration for this year (if there is one)
  def current_reg
    self.registrations.reg_order[0] unless self.registrations.nil?
  end
  
  #insert age as of june 1 method
  def age_as_of_june_1
    return nil if self.dob.blank? #should never be blank
    (Date.new(Date.today.year, 6, 1).to_time.to_s(:number).to_i - self.dob.to_time.to_s(:number).to_i)/10e9.to_i
  end

  # Private methods
  private
  def reformat_emergency_phone
    phone = self.emergency_contact_phone.to_s  # change to string in case input as all numbers 
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.emergency_contact_phone = phone       # reset self.phone to new string
  end

  def reformat_cell
    phone = self.cell_phone.to_s  # change to string in case input as all numbers 
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.cell_phone = phone       # reset self.phone to new string
  end
end
