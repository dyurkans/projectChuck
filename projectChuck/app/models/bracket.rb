class Bracket < ActiveRecord::Base
  attr_accessible :gender, :max_age, :min_age, :tournament_id

  has_many :teams
  belongs_to :tournament

  GENDER_LIST = [["Male", true], ["Female", false]]

  validates_numericality_of :tournament_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :min_age, :only_integer => true, :greater_than_or_equal_to => 7 
  validates_numericality_of :max_age, :only_integer => true, :less_than_or_equal_to => 18
  validates_inclusion_of :gender, :in => [true, false], :message => "must be true or false"

  scope :by_gender, order('gender')
  scope :by_age, order('min_age, max_age')

  def sex
    return "Male" if gender == true
    "Female"
  end

  def gender_name
    GENDER_LIST.map{|genders| genders[1] == gender}
  end

  def name
  	"#{self.sex} #{self.min_age} - #{self.max_age}"
  end

end