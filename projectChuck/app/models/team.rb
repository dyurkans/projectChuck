require 'active_support'
require 'application_helper'
class Team < ActiveRecord::Base
  attr_accessible :bracket_id, :max_students, :name
  
  BOYS_TEAM_LIST = [["Atlanta Hawks",0],["Brooklyn Nets",1],["Boston Celtics",2],
                ["Charlotte Bobcats",3],["Chicago Bulls",4],["Cleveland Cavaliers",5],
                ["Dallas Mavericks",6],["Denver Nuggets",7],["Detroit Pistons", 8],
                ["Golden State Warriors",9],["Houston Rockets",10],["Indiana Pacers",11],
                ["Los Angeles Clippers",12],["Los Angeles Lakers",13],["Memphis Grizzlies",14],
                ["Miami Heat",15],["Milwaukee Bucks",16],["Minnesota Timberwolves",17],
                ["New Orleans Pelicans",18],["New York Knicks",19],["Oklahoma City Thunder",20],
                ["Orlando Magic",21],["Philadelphia 76ers",22],["Phoenix Suns",23],
                ["Portland Trail Blazers",24],["Sacramento Kings",25],["San Antonio Spurs",26],
                ["Toronto Raptors",27],["Utah Jazz",28],["Washington Wizards",29]]

  GIRLS_TEAM_LIST = [["Atlanta Dream",30],["Chicago Sky",31],["Connecticut Sun",32],
                      ["Indiana Fever",33],["Los Angeles Sparks",34],["Minnesota Lynx",35],
                      ["New York Liberty",36], ["Washington Mystics",37],["Phoenix Mercury",38],
                      ["San Antonio Stars",39],["Seattle Storm Seattle",30],["Tulsa Shock",31]]
  
  FULL_TEAM_LIST = BOYS_TEAM_LIST + GIRLS_TEAM_LIST
  
  belongs_to :bracket
  has_many :registrations
  has_many :students, :through => :registrations
  validates_numericality_of :bracket_id, :only_integer => true, :greater_than => 0
  validates_inclusion_of :name, :in => FULL_TEAM_LIST.map{ |t| t[1]}, :message => "must be proper team name"
  validates_numericality_of :max_students, :only_integer => true, :greater_than => 4, :less_than_or_equal_to => 10
  # max may not always be 10
  validate :max

  scope :alphabetical, order('name')
  scope :by_bracket, joins(:bracket).order('min_age, name')


  # max may not always be 10
  def max
  	max_students <= 10 
  end

  def remaining_spots
  	current_registrants = Registration.where(:team_id => id).size()
  	max_students - current_registrants
  end

  def self.unassigned_teams
    assigned_teams = self.all.map{ |t| team_name(t.name) }
    Team::FULL_TEAM_LIST.select{ |t| !assigned_teams.include?(t[0]) }
  end

end
