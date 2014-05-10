class Student < ActiveRecord::Base  
  # Relationships
  belongs_to :household
  has_many :registrations
  has_many :guardians, :through => :household
  has_many :teams, :through => :registrations
  
  mount_uploader :birth_certificate, AvatarUploader

  accepts_nested_attributes_for :registrations, :household
  attr_accessible :registrations_attributes, :household_attributes, :birth_certificate_cache, :email, :active, :allergies, :birth_certificate, :cell_phone, :dob, :emergency_contact_name, :emergency_contact_phone, :first_name, :gender, :grade_integer, :household_id, :last_name, :medications, :school, :school_county, :security_question, :security_response
  
  #Callbacks
  before_save :reformat_cell
  before_save :reformat_emergency_phone
  before_destroy :check_if_destroyable
  #after_rollback :deactivate_student_and_registrations, :on => :destory


  #Validations (email commented out b/c not in the database)
  validates_presence_of :first_name, :last_name, :emergency_contact_name, :school, :school_county, :security_response, :security_question, :grade_integer, :security_question, :dob, :message => "Can't be blank"
  validates_date :dob, :on_or_before => 7.years.ago.to_date, :after => 19.years.ago.to_date, :message => "Must be between the ages of 7 and 18 (inclusive)"  # Documentation didn't show proper syntax for  between message. #:on_or_before_message => "must 
  validates_format_of :cell_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "Should be 10 digits (area code needed) and separated with dashes only", :allow_blank => true, :allow_nil => true
  validates_format_of :emergency_contact_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "Should be 10 digits (area code needed) and separated with dashes only"
  # validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format"
  validates_inclusion_of :gender, :in => [true, false]
  validates_inclusion_of :active, :in => [true, false]
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

  
  SCHOOL_DISTRICT_LIST = [["Allegheny Valley School District",0],["Avonworth School District",1],
                          ["Baldwin-Whitehall School District",2],["Bethel Park School District",3],
                          ["Brentwood Borough School District",4],["Carlynton School District",5],
                          ["Chartiers Valley School District",6],["Clairton City School District",7],
                          ["Cornell School District",8],["Deer Lakes School District",9],
                          ["Duquesne City School District",10],["East Allegheny School District",11],
                          ["Elizabeth Forward School District",12],["Fox Chapel Area School District",13],
                          ["Gateway School District",14],["Hampton Township School District",15],
                          ["Highlands School District",16],["Keystone Oaks School District",17],
                          ["McKeesport Area School District",18],["Montour School District",19],
                          ["Moon Area School District",20],["Mt. Lebanon School District",21],
                          ["North Allegheny School District",22],["North Hills School District",23],
                          ["Northgate School District",24],["Penn Hills School District",25],
                          ["Pine-Richland School District",26],["Plum Borough School District",27],
                          ["Quaker Valley School District",28],["Riverview School District",29],
                          ["Shaler Area School District",30],["South Allegheny School District",31],
                          ["South Fayette Township School District",32], ["Steel Valley School District",33],
                          ["Sto-Rox School District",34],["Upper St. Clair School District",35],
                          ["West Allegheny School District",36],["West Jefferson Hills School District",37],
                          ["West Mifflin Area School District",38],["Wilkinsburg School District",39],
                          ["Woodland Hills School District",40]]
  
  # Scopes
  scope :alphabetical, order('last_name, first_name')
  scope :by_age, order('dob DESC')
  scope :male, where('gender = ?', true)
  scope :female, where('gender = ?', false)
  scope :active, where('students.active = ?', true)
  scope :inactive, where('students.active = ?', false)
  scope :by_grade, order('grade_integer')
  scope :grade, lambda {|grade_integer| where("grade_integer = ?", grade_integer)}
  scope :by_school, order('school')
  scope :by_county, order('school_county')
  scope :has_allergies, where('allergies <> ""')
  scope :needs_medication, where('medications <> ""')
  scope :seniors, where('grade_integer = ?', 13)
  scope :without_forms, joins(:registrations).where('students.birth_certificate IS NULL OR physical IS NULL OR proof_of_insurance IS NULL OR report_card IS NULL')
  scope :unassigned, joins(:registrations).where('team_id IS NULL')
  scope :current, joins(:registrations).where('? <= registrations.created_at and registrations.created_at <= ? and registrations.active = ?', Date.new(Date.today.year,1,1), Date.new(Date.today.year,12,31), true)
  # Other methods

  def self.missing_forms(stus)
    students_missing_docs = []
    for stu in stus
      if stu.registrations.current.first.proof_of_insurance.blank? or stu.registrations.current.first.physical.blank? or stu.registrations.current.first.report_card.blank? or stu.birth_certificate.blank?
        students_missing_docs << stu
      end
    end
    students_missing_docs
  end

  def self.school_districts
    current_registered_students = Student.current.active
    school_districts = []
    for stu in current_registered_students
      if !school_districts.include?([stu.school_county,0])
        school_districts << [stu.school_county, 0]
      end
    end
    for student in current_registered_students
      for district in school_districts
        if district.first == student.school_county
          district[1] += 1 
        end
      end
    end
    school_districts
  end

  def self.home_counties
    current_registered_students = Student.current.active
    home_counties = []
    for stu in current_registered_students
      house = Household.find(stu.household_id)
      if !home_counties.include?([house.county,0])
        home_counties << [house.county, 0]
      end
    end
    for student in current_registered_students
      house = Household.find(student.household_id)
      for county in home_counties
        if county.first == house.county
          county[1] += 1 
        end
      end
    end
    home_counties
  end

  def check_if_destroyable
    true
  end

  # def self.current_registered_students
  #   active_regs = Registration.current.active.by_name
  #   students = Student.active
  #   current_registered_students = []
  #   for r in active_regs
  #     current_registered_students << students.find(r.student_id)
  #   end
  #   current_registered_students
  # end   

  def deactivate_student_and_registrations
    self.active = false
    self.save! 
    unless self.registrations.nil? || self.registrations.empty?
      for reg in self.registrations.active
        reg.update_attribute(:active, false)
        reg.save!
      end      
    end
  end
  
  def missing_report_card
    self.registrations.current[0].report_card.blank? unless (self.registrations.current[0].nil? || self.registrations.current.empty?)
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
    if dob.blank? then nil else (Time.now.to_s(:number).to_i - dob.to_time.to_s(:number).to_i)/10e9.to_i end
  end

  def sex
    if gender == true then "Male" else "Female" end
  end
  
  def proper_grade
    index_of_grade_name = 0
    GRADES_LIST[grade_integer-1][index_of_grade_name]
  end
    

  # Method to find student's registration for this year (if there is one)
  def current_reg
    self.registrations.current[0] unless self.registrations.current[0].nil?
  end
  
  #insert age as of june 1 method
  def age_as_of_june_1
    if self.dob.blank? then nil else (Date.new(Date.today.year, 6, 1).to_time.to_s(:number).to_i - self.dob.to_time.to_s(:number).to_i)/10e9.to_i end
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
