class Student < ActiveRecord::Base
  attr_accessible :active, :allergies, :birth_certificate, :cell_phone, :dob, :emergency_contact_name, :emergency_contact_phone, :first_name, :gender, :grade_integer, :household_id, :last_name, :medications, :school, :school_county, :security_question, :security_response

  # Relationships
  belongs_to :household
  has_many :registrations
  has_many :teams, :through => :registrations

  #Validations
  validates_presence_of :first_name, :last_name, :emergency_contact_name, :school, :school_county, :birth_certificate
  validates_date :dob, :between => [7.years.ago, 19.years.ago], :message => "must be between the ages of 7 and 18 included"  # Documentation didn't show proper syntax for  between message. #:on_or_before_message => "must 
  validates_format_of :cell_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  validates_format_of :emergency_contact_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
  validates_inclusion_of :gender, :in => [true, false], :message => "must be true or false"
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  #validates_inclusion_of :security_question, :in => SECURITY_QUESTIONS.map() #Need to check how mapping works
  #validates_inclusion_of :security_response, :in => SECURITY_RESPONSES.map() #Need to check how mapping works
  #Add these tests to student_test file
  validates_numericality_of :household_id, :only_integer => true, :greater_than => 0

  #SECURITY_QUESTIONS = [[], [], [], [], [], []]
  #SECURITY_RESPONSES = [[], [], [], [], [], []]
  #security questions: "What was the name of your first pet", ""

  # Scopes
  scope :alphabetical, order('last_name, first_name')
  scope :by_age, order('dob')
  scope :male, where('students.gender = ?', true)
  scope :female, where('students.gender = ?', false)
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :by_school, order('school')
  scope :by_county, order('school_county')
  #by_grade

  # Replaced with gender method GENDER_LIST = [["Male", true], ["Female", false]]
  #add list of security questions

  # Other methods
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

  #insert age as of june 1 method

  def gender
    return "Male" if gender == true
    "Female"
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
