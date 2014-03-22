class Guardian < ActiveRecord::Base
  attr_accessible :active, :cell_phone, :day_phone, :dob, :email, :first_name, :gender, :household_id, :last_name, :receive_texts

  has_one :user
  belongs_to :household

  validates_presence_of :first_name, :last_name
  validates_date :dob, :on_or_before => lambda { 18.years.ago }, :on_or_before_message => "must be at least 18 years old" 
  validates_format_of :day_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  validates_format_of :cell_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
  validates_inclusion_of :receive_texts, :in => [true, false], :message => "must be true or false"
  validates_inclusion_of :gender, :in => [true, false], :message => "must be true or false"
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  validates_numericality_of :household_id, :only_integer => true, :greater_than => 0

  #Scopes
  scope :alphabetical, order('last_name, first_name')
  scope :active, where('guardians.active = ?', true)
  scope :inactive, where('guardians.active = ?', false)
  #double check this scope below
  scope :children, joins(:household, :student).where('student.household_id => ?', household_id)

  #Replaced with gender method. GENDER_LIST = [["Male", true], ["Female", false]]

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

  def gender
    return "Male" if gender == true
    "Female"
  end

  # Private methods
  private
  def reformat_phone
    phone = self.day_phone.to_s  # change to string in case input as all numbers 
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.day_phone = phone       # reset self.phone to new string
  end

  def reformat_cell
    phone = self.cell_phone.to_s  # change to string in case input as all numbers 
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.cell_phone = phone       # reset self.phone to new string
  end

end
