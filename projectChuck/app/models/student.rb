class Student < ActiveRecord::Base
  attr_accessible :active, :allergies, :birth_certificate, :cell_phone, :dob, :emergency_contact_name, :emergency_contact_phone, :first_name, :gender, :grade_integer, :household_id, :last_name, :medications, :school, :school_county, :security_question, :security_response

  # Relationships
  belongs_to :household
  has_many :registrations
  has_many :teams, :through => :registrations

  #Validations
  validates_presence_of :first_name, :last_name, :emergency_contact_name, :school, :school_county, :birth_certificate, :security_response, :security_question
  validates_date :dob, :on_or_before => lambda { 7.years.ago }, :on_or_before_message => "must be at least 18 years old" 
  validates_format_of :emergency_contact_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  validates_format_of :cell_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
  validates_inclusion_of :gender, :in => [true, false], :message => "must be true or false"
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  validates_numericality_of :household_id, :only_integer => true, :greater_than => 0

  # Scopes
  scope :alphabetical, order('last_name, first_name')
  scope :by_age, order('dob')
  scope :male, where('students.gender = ?', true)
  scope :female, where('students.gender = ?', false)
  scope :in_household, lambda {|household_id| where("household_id = ?", household_id) }
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)


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
