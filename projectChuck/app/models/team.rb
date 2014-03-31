class Team < ActiveRecord::Base
  attr_accessible :bracket_id, :max_students, :name
  
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

  belongs_to :bracket
  has_many :students, :through => :registrations

  validates_numericality_of :bracket_id, :only_integer => true, :greater_than => 0
  validates_inclusion_of :name, :in => TEAMS_LIST, :message => "must be proper team name"
  validates_numericality_of :max_students, :only_integer => true, :greater_than => 2
  validate :max

  scope :alphabetical, order('name')
  scope :by_bracket, joins(:bracket).order('min_age, name')


  def max
  	max_students == 10
  end

  def remaining_spots
  	max_students - self.registrations.size()
  end



end
