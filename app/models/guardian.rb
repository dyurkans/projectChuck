class Guardian < ActiveRecord::Base
  has_one :user
  belongs_to :household
  has_many :students, through: :household

  accepts_nested_attributes_for :household, :students
  attr_accessible :household_attributes, :students_attributes, :active, :cell_phone, :day_phone, :email, :first_name, :gender, :household_id, :last_name, :receive_texts

  
  #Callbacks
  before_save :reformat_cell
  before_save :reformat_phone

  validates_presence_of :first_name, :last_name, :message => "Can't be blank"
  validates_format_of :day_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "Should be 10 digits (area code needed) and separated with dashes only", :allow_blank => true, :allow_nil => true
  validates_format_of :cell_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "Should be 10 digits (area code needed) and separated with dashes only", :allow_blank => true, :allow_nil => true
  validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "Email is not in a valid format", :allow_blank => true, :allow_nil => true
  validates_inclusion_of :receive_texts, :in => [true, false]
  validates_inclusion_of :gender, :in => [true, false]
  validates_inclusion_of :active, :in => [true, false]
  validates_uniqueness_of :email, :case_sensitive => false
  validates_numericality_of :household_id, :only_integer => true, :greater_than => 0, :allow_nil => true

  #Scopes
  scope :alphabetical, order('last_name, first_name')
  scope :active, where('guardians.active = ?', true)
  scope :inactive, where('guardians.active = ?', false)
  scope :receive_text_notifications, where('receive_texts = ?', true)

  # Other methods
  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end

  def sex
    if gender == true then "Male" else "Female" end
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
