class Registration < ActiveRecord::Base
  attr_accessible :active, :physical, :physical_date, :proof_of_insurance, :report_card, :student_id, :t_shirt_size, :team_id, :created_at

  # Prof H suggested moving proof of insurance to household. 
  # Can someone write a migration for that and move the tests and code here appropriately.

  #Relationships
  belongs_to :student
  belongs_to :team
  mount_uploader :report_card, AvatarUploader
  mount_uploader :physical, AvatarUploader
  mount_uploader :proof_of_insurance, AvatarUploader

  
  #Local Variables
  SIZE_LIST = [['S', 1], ['M', 2], ['L',3], ['XL',4], ['XXL',5], ['XXXL',6]]
  TEAMS_LIST = [["Atlanta Hawks",0],["Brooklyn Nets",1],["Boston Celtics",2],
                ["Charlotte Bobcats",3],["Chicago Bulls",4],["Cleveland Cavaliers",5],
                ["Dallas Mavericks",6],["Denver Nuggets",7],["Detroit Pistons", 8],
                ["Golden State Warriors",9],["Houston Rockets",10],["Indiana Pacers",11],
                ["Los Angeles Clippers",12],["Los Angeles Lakers",13],["Memphis Grizzlies",14],
                ["Miami Heat",15],["Milwaukee Bucks",16],["Minnesota Timberwolves",17],
                ["New Orleans Pelicans",18],["New York Knicks",19],["Oklahoma City Thunder",20],
                ["Orlando Magic",21],["Philadelphia 76ers",22],["Phoenix Suns",23],
                ["Portland Trail Blazers",24],["Sacramento Kings",25],["San Antonio Spurs",26],
                ["Toronto Raptors",27],["Utah Jazz",28],["Washington Wizards",30]]
  
  #Validations
  validates_numericality_of :student_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :team_id, :only_integer => true, :greater_than => 0
  validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  validates_date :physical_date, :on_or_before => lambda { Date.current }, :on_or_before_message => "cannot be in the future"
  validates_numericality_of :t_shirt_size, :only_integer => true, :greater_than => 0
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
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :missing_doc, where('missing_insurance = ? || missing_physical = ? || missing_report_card = ?', nil, nil, nil)


  #Other Methods

  def student_in_appropriate_bracket
    team = Team.find_by_id(team_id)
    bracket = Bracket.find_by_id(team.bracket_id)
    student = Student.find_by_id(student_id)
    return true if student.nil? || team.nil? || bracket.nil? # should be caught by other validations; no double error
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


end
