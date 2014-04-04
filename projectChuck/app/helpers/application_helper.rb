module ApplicationHelper
  def team_name(team_id)
    case
    when team_id == 0
      "Atlanta Hawks"
    when team_id == 1
      "Brooklyn Nets"
    when team_id == 2
      "Boston Celtics"
    when team_id == 3
      "Charlotte Bobcats"
    when team_id == 4
      "Chicago Bulls"
    when team_id == 5
      "Cleveland Cavaliers"
    when team_id == 6
      "Dallas Mavericks"
    when team_id == 7
      "Denver Nuggets"
    when team_id == 8
      "Detroit Pistons"
    when team_id == 9
      "Golden State Warriors"
    when team_id == 10
      "Houston Rockets"
    when team_id == 11
      "Indiana Pacers"
    when team_id == 12
      "Los Angeles Clippers"
    when team_id == 13
      "Los Angeles Lakers"
    when team_id == 14
    	"Memphis Grizzlies"
    when team_id == 15
    	"Miami Heat"
    when team_id == 16
    	"Milwaukee Bucks"
    when team_id == 17
    	"Minnesota Timberwolves"
    when team_id == 18
    	"New Orleans Pelicans"
    when team_id == 19
    	"New York Knicks"
    when team_id == 20
    	"Oklahoma City Thunder"
    when team_id == 21
    	"Orlando Magic"
    when team_id == 22
    	"Philadelphia 76ers"
    when team_id == 23
    	"Phoenix Suns"
    when team_id == 24
    	"Portland Trail Blazers"
    when team_id == 25
    	"Sacramento Kings"
    when team_id == 26
    	"San Antonio Spurs"
    when team_id == 27
    	"Toronto Raptors"
    when team_id == 28
    	"Utah Jazz"
    when team_id == 29
    	"Washington Wizards"
    when team_id == 30
    	"Atlanta Dream"
    when team_id == 31
    	"Chicago Sky"
    when team_id == 32
    	"Connecticut Sun"
    when team_id == 33
    	"Indiana Fever"
    when team_id == 34
    	"Los Angeles Sparks"
    when team_id == 35
    	"Minnesota Lynx"
    when team_id == 36
    	"New York Lib7erty"
    when team_id == 37
    	"Phoenix Mercury"
    when team_id == 38
    	"San Antonio Silver Stars"
    when team_id == 39
    	"Seattle Storm"
    when team_id == 40
    	"Tulsa Shock"
    else
    	"Washington Mystics"
    end
  end

  def unassigned_teams()
    all_teams = Team::FULL_TEAM_LIST #2d array
    assigned_teams = [] #1d array
    unassigned_teams = []
    for t in Team.all do
     assigned_teams << t.name
    end
    all_teams.each do |team|
      if !team[0].in?(assigned_teams)
        unassigned_teams << team
      end
    end
    return unassigned_teams  
  end

end
