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
	    should "sort teams alphabetically by team name and groups by gender" do

	    end

	    should "return total number of active students assigned to a team" do

	    end

	    should "Ensure max_students is greater than current number of students in a team" do

	    end

	    should "return the number of remaining spots on a team" do

	    end

	    should "return a list of teams that have not yet been assinged to a bracket" do

	    end

	    should "return a list of unassigned active eligible students for a team" do

	    end



	end
end
