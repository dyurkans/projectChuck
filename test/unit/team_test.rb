require 'test_helper'

class TeamTest < ActiveSupport::TestCase

	#Relationship Validations
	should belong_to(:bracket)
	should have_many(:registrations)
	should have_many(:students).through(:registrations)

	#test max students
	should allow_value(10).for(:max_students)
	should_not allow_value(4).for(:max_students)
	should_not allow_value(11).for(:max_students)
	should_not allow_value(nil).for(:max_students)
	should_not allow_value("six").for(:max_students)

	# #test name
	should allow_value(5).for(:name)
	should allow_value(0).for(:name)
	should_not allow_value(729).for(:name)
	#failing validation. even with map, still finding the string in the 0th index of array
	# should_not allow_value("Toronto Raptors").for(:name)

	#test bracket_id
	should validate_numericality_of(:bracket_id)
	should allow_value(3).for(:bracket_id)
	should_not allow_value(3.14159).for(:bracket_id)
	should_not allow_value(0).for(:bracket_id)
	should_not allow_value(-1).for(:bracket_id)
	should_not allow_value(nil).for(:bracket_id)

	# # tests for coach_cell
	should allow_value("4122683259").for(:coach_cell)
	should allow_value("412-268-3259").for(:coach_cell)
	should allow_value("412.268.3259").for(:coach_cell)
	should allow_value("(412) 268-3259").for(:coach_cell)
	should allow_value(nil).for(:coach_cell)
	should_not allow_value("2683259").for(:coach_cell)
	should_not allow_value("14122683259").for(:coach_cell)
	should_not allow_value("4122683259x224").for(:coach_cell)
	should_not allow_value("800-EAT-FOOD").for(:coach_cell)
	should_not allow_value("412/268/3259").for(:coach_cell)
	should_not allow_value("412-2683-259").for(:coach_cell)

	# # tests for assistant_coach_cell
	should allow_value("4122683259").for(:assistant_coach_cell)
	should allow_value("412-268-3259").for(:assistant_coach_cell)
	should allow_value("412.268.3259").for(:assistant_coach_cell)
	should allow_value("(412) 268-3259").for(:assistant_coach_cell)
	should allow_value(nil).for(:assistant_coach_cell)
	should_not allow_value("2683259").for(:assistant_coach_cell)
	should_not allow_value("14122683259").for(:assistant_coach_cell)
	should_not allow_value("4122683259x224").for(:assistant_coach_cell)
	should_not allow_value("800-EAT-FOOD").for(:assistant_coach_cell)
	should_not allow_value("412/268/3259").for(:assistant_coach_cell)
	should_not allow_value("412-2683-259").for(:assistant_coach_cell)

	# # tests for coach_email
	should allow_value("fred@fred.com").for(:coach_email)
	should allow_value("fred@andrew.cmu.edu").for(:coach_email)
	should allow_value("my_fred@fred.org").for(:coach_email)
	should allow_value("fred123@fred.gov").for(:coach_email)
	should allow_value("my.fred@fred.net").for(:coach_email)
	should_not allow_value("fred").for(:coach_email)
	should_not allow_value("fred@fred,com").for(:coach_email)
	should_not allow_value("fred@fred.uk").for(:coach_email)
	should_not allow_value("my fred@fred.com").for(:coach_email)
	should_not allow_value("fred@fred.con").for(:coach_email)

	# # # tests for assistant_coach_email
	should allow_value("fred@fred.com").for(:assistant_coach_email)
	should allow_value("fred@andrew.cmu.edu").for(:assistant_coach_email)
	should allow_value("my_fred@fred.org").for(:assistant_coach_email)
	should allow_value("fred123@fred.gov").for(:assistant_coach_email)
	should allow_value("my.fred@fred.net").for(:assistant_coach_email)
	should_not allow_value("fred").for(:assistant_coach_email)
	should_not allow_value("fred@fred,com").for(:assistant_coach_email)
	should_not allow_value("fred@fred.uk").for(:assistant_coach_email)
	should_not allow_value("my fred@fred.com").for(:assistant_coach_email)
	should_not allow_value("fred@fred.con").for(:assistant_coach_email)

	context "Creating a team context" do
	    setup do
			create_household_context
			create_student_context
			create_tournament_context
			create_bracket_context
			create_team_context
			create_registration_context
	    end
	      
	    teardown do
			remove_registration_context
			remove_team_context
			remove_bracket_context
			remove_tournament_context
			remove_student_context
			remove_household_context
	    end

	    should "have working factories" do
	    	@grub.valid?
	    	@mill.valid?
	    	@suth.valid?
	    	@bam.valid?
	    	@ed.valid?
			@ted.valid?
			@fred.valid?
			@ned.valid?
			@noah.valid?
			@howard.valid?
			@jen.valid?
			@julie.valid?
			@jason.valid?
			@tourn.valid? 
			@tourn2.valid? 
			@tourn3.valid? 
			@boys7to9.valid? 
			@boys10to12.valid? 
			@boys13to15.valid? 
			@boys16to18.valid? 
			@littlegirls.valid? 
			@youngwomen.valid?	
			@pistons.valid? 
			@wizards.valid? 
			@heat.valid? 
			@lakers.valid? 
			@knicks.valid? 
			@mavs.valid? 
			@reg1.valid? 
			@reg2.valid? 
			@reg3.valid? 
			@reg4.valid? 
			@reg5.valid? 
			@reg6.valid? 
			@reg7.valid? 
			@reg8.valid? 
			@reg9.valid? 
	    end

	    #This groups by gender as a result of the hardcoded list. This grouping is useful for separation in team dropdowns.
	    #Given the harcoded list, the alphabetical order is based on the index number, so any unlikely additions or 
	    #modifications to maintain the order desired according to index for this scope to function properly
	    should "sort teams alphabetically by team name and groups by gender" do
	    	assert_equal [@pistons, @wizards, @heat, @lakers, @knicks, @mavs], Team.alphabetical
	     	@newTeam = FactoryGirl.create(:team, bracket: @boys7to9, name: "Atlanta Hawks")
		    assert_equal false, [@newTeam, @pistons, @wizards, @heat, @lakers, @knicks, @mavs] == Team.alphabetical
	     	assert_equal true, [@pistons, @wizards, @heat, @lakers, @knicks, @mavs, @newTeam] == Team.alphabetical
	     	@newTeam.destroy
	    end

	    should "return total number of active students assigned to a team" do
	    	#Team with many student
	    	assert_equal 3, @heat.current_number_of_students
	    	#Team with zero students
	    	@newTeam = FactoryGirl.create(:team, bracket: @boys7to9, name: "Atlanta Hawks")
	    	assert_equal 0, @newTeam.current_number_of_students
	    	#Team with inactive registrations
	    	@newStu = FactoryGirl.create(:student, household: @mill, first_name: "Julie", last_name: "Henderson", gender: true, dob: Date.new(8.years.ago.year, 8, 1), grade_integer: 13, email: "newStu@example.com")
    		@inactiveReg = FactoryGirl.create(:registration, student: @newStu, team: @newTeam, active: false)
    		@newStu2 = FactoryGirl.create(:student, household: @mill, first_name: "Julie", last_name: "Henderson", gender: true, dob: Date.new(8.years.ago.year, 8, 1), grade_integer: 13, email: "newStu2@example.com")
    		@activeReg2 = FactoryGirl.create(:registration, student: @newStu2, team: @newTeam, active: true)
    		assert_equal 1, @newTeam.current_number_of_students
	    	@newTeam.destroy
	    	@newStu.destroy
			@inactiveReg.destroy
			@newStu2.destroy
			@activeReg2.destroy
	    end

	    should "Ensure max_students is greater than current number of students in a team" do
	    	assert_equal true, @heat.max
	    	@mavs.max_students = 5
	    	@newStu = FactoryGirl.create(:student, household: @mill, first_name: "Julie", last_name: "Henderson", gender: true, medications: "insulin", dob: Date.new(14.years.ago.year,8,1), grade_integer: 13, email: "newStu@example.com")
    		@newStu2 = FactoryGirl.create(:student, household: @mill, first_name: "Julie", last_name: "Henderson", gender: true, medications: "insulin", dob: Date.new(14.years.ago.year,8,1), grade_integer: 13, email: "newStu2@example.com")
    		@activeReg = FactoryGirl.create(:registration, student: @newStu, team: @heat, active: true)
    		@activeReg2 = FactoryGirl.create(:registration, student: @newStu2, team: @heat, active: true)
	    	assert_equal false, @heat.max 
	    end

	    should "return the number of remaining spots on a team" do
	    	#Multiple active students on team
	    	assert_equal 8, @wizards.remaining_spots
	    	#Active and inactive students on a team
	    	assert_equal 9, @pistons.remaining_spots
	    	#Empty team with lowered max students
	    	@newTeam = FactoryGirl.create(:team, bracket: @boys7to9, name: "Atlanta Hawks", max_students: 5)
	    	assert_equal 5, @newTeam.remaining_spots
	    	@newTeam.destroy
	    end

	    should "return a list of teams that have not yet been assinged to a bracket" do
	    	assert_equal [["Atlanta Hawks",0],["Brooklyn Nets",1],["Boston Celtics",2],["Charlotte Bobcats",3],["Chicago Bulls",4],["Cleveland Cavaliers",5],["Denver Nuggets",7],["Golden State Warriors",9],["Houston Rockets",10],["Indiana Pacers",11],["Los Angeles Clippers",12],["Memphis Grizzlies",14],["Milwaukee Bucks",16],["Minnesota Timberwolves",17],["New Orleans Pelicans",18],["Oklahoma City Thunder",20],["Orlando Magic",21],["Philadelphia 76ers",22],["Phoenix Suns",23],["Portland Trail Blazers",24],["Sacramento Kings",25],["San Antonio Spurs",26],["Toronto Raptors",27],["Utah Jazz",28],["Atlanta Dream",30],["Chicago Sky",31],["Connecticut Sun",32],["Indiana Fever",33],["Los Angeles Sparks",34],["Minnesota Lynx",35],["New York Liberty",36], ["Washington Mystics",37],["Phoenix Mercury",38],["San Antonio Stars",39],["Seattle Storm Seattle",40],["Tulsa Shock",41]], Team.unassigned_teams(@mavs.name)

	    end

	    should "return a list of unassigned active eligible students for a team" do
	    	#Full team with no more eligible students
	    	assert_equal [], @heat.eligible_students
	    	#Active and Inactive eligible students
	    	@newStu = FactoryGirl.create(:student, household: @mill, first_name: "Julie", last_name: "Henderson", gender: true, dob: Date.new(14.years.ago.year,8,1), grade_integer: 13, email: "newStu@example.com")
    		@newStu2 = FactoryGirl.create(:student, household: @mill, first_name: "Julie", last_name: "Henderson", gender: true, dob: Date.new(14.years.ago.year,8,1), grade_integer: 13, email: "newStu2@example.com")
    		@activeReg = FactoryGirl.create(:registration, student: @newStu, team: nil, active: true)
    		@activeReg2 = FactoryGirl.create(:registration, student: @newStu2, team: nil, active: false)
    		assert_equal [@newStu], @heat.eligible_students
    		#Multiple Active Students
    		@activeReg2.active = true
    		@activeReg2.save!
    		assert_equal [@newStu, @newStu2], @heat.eligible_students
    		#Male and Female sudents eligible by age, but not gender. Should not include female in result for male team
    		@newStu2.gender = false
    		@activeReg2.save!
    		assert_equal [@newStu], @heat.eligible_students
	    end

	end
end
