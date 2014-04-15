class Registration < ActiveRecord::Base
  # Prof H suggested moving proof of insurance to household. 
  # Can someone write a migration for that and move the tests and code here appropriately.

  #Relationships
  belongs_to :student
  belongs_to :team
  mount_uploader :report_card, AvatarUploader
  mount_uploader :physical, AvatarUploader
  mount_uploader :proof_of_insurance, AvatarUploader

  accepts_nested_attributes_for :student
  
  attr_accessible :student_attributes, :active, :physical, :physical_date, :proof_of_insurance, :report_card, :student_id, :t_shirt_size, :team_id, :created_at
  
  #Local Variables
  SIZE_LIST = [['S', 0], ['M', 1], ['L',2], ['XL',3], ['XXL',4], ['XXXL',5]]
  
  #Validations
  validate :student_in_allowable_age_range
  validates_numericality_of :student_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :team_id, :only_integer => true, :greater_than => 0, :allow_nil => true # needs to be removed later
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  validates_date :physical_date, :on_or_after => lambda { Date.new(Date.today.year-1, 8, 1) }, :on_or_before => lambda { Date.today }, :on_or_before_message => "cannot be in the future"
  validates_numericality_of :t_shirt_size, :allow_blank => false, :allow_nil => false, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => SIZE_LIST.size
  validates_inclusion_of :t_shirt_size, :in => SIZE_LIST.map {|k, v| v}, :message => "unavailable size chosen"
  validate :student_in_appropriate_bracket

  #Scopes
  scope :alphabetical, joins(:student).order('last_name')
  scope :for_team, joins(:team).order('name')
  scope :reg_order, order('created_at DESC')
  scope :physicals, where('physical IS NOT NULL')
  scope :report_cards, where('report_card IS NOT NULL')
  scope :missing_insurance, where('proof_of_insurance = ?', nil)
  scope :missing_physical, where('physical = ?', nil)
  scope :missing_report_card, where('report_card = ?', nil)
  scope :current, where('created_at > ?', Date.new(Date.today.year,1,1))
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :incomplete, where('proof_of_insurance = ? || physical = ? || report_card = ?', nil, nil, nil)
  scope :jersey_size, lambda {|size| where("t_shirt_size = ?", size) }

  #Other Methods

  def student_in_appropriate_bracket
    return false if team_id.nil?
    team = Team.find_by_id(team_id)
    return false if team.nil? || team.bracket_id.nil?
    bracket = Bracket.find_by_id(team.bracket_id)
    return false if bracket.nil? || student_id.nil?
    student = Student.find_by_id(student_id)
    return true if student.nil? # should be caught by other validations; no double error
    age = student.age
    min = bracket.min_age
    max = bracket.max_age
    unless age >= min && (max.nil? || age <= max)
      errors.add(:student_id, "is not within the age range for this section")
    end
  end

  def registration_is_not_already_in_system
    return true if self.student_id.nil? || self.team_id.nil? # should be caught by other validations; no double error
    possible_repeat = Registration.where(team_id: team_id, student_id: student_id)
    # notice that I am using the Ruby 1.9 hashes here as opposed to the 1.8 style in Section
    # again, an alternate method would be using the dynamic find_by method...
    # possible_repeat = Registration.find_by_section_id_and_student_id(section_id, student_id)
    unless possible_repeat.empty? # use .nil? if using find_by as it only returns one object, not an array
      errors.add(:student_id, "is already registered for this section")
    end
  end

  def missing_doc
    return true if self.proof_of_insurance.nil? || self.physical.nil? || self.report_card.nil?
  end

  private
  def student_in_allowable_age_range
    return false if student_id.nil?
    student = Student.find_by_id(student_id)
    return false if student.nil?
    age = student.age_as_of_june_1
    if age >= 7 or age <= 18
      true
    else
      false
    end
  end



end
