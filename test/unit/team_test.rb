require 'test_helper'

class TeamTest < ActiveSupport::TestCase

	#Relationship Validations
	should belong_to(:bracket)
	should have_many(:registrations)
	should have_many(:students).through(:registrations)

	#test max students
	# should allow_value(10).for(:max_students)
	# should_not allow_value(4).for(:max_students)
	# should_not allow_value(11).for(:max_students)
	# should allow_value(nil).for(:max_students)
	# should_not allow_value("six").for(:max_students)

	# #test name
	# # should ensure_inclusion_of(5).in(FULL_TEAM_LIST)
	# should allow_value(5).for(:name)
	# should allow_value(0).for(:name)
	# should_not allow_value(729).for(:name)
	# should_not allow_value("Toronto Raptors").for(:name)

	#test bracket_id
	should validate_numericality_of(:bracket_id)
	should allow_value(3).for(:bracket_id)
	should_not allow_value(3.14159).for(:bracket_id)
	should_not allow_value(0).for(:bracket_id)
	should_not allow_value(-1).for(:bracket_id)
	should_not allow_value(nil).for(:bracket_id)

	# # tests for coach_cell
	# should allow_value("4122683259").for(:coach_cell)
	# should allow_value("412-268-3259").for(:coach_cell)
	# should allow_value("412.268.3259").for(:coach_cell)
	# should allow_value("(412) 268-3259").for(:coach_cell)
	# should allow_value(nil).for(:coach_cell)
	# should_not allow_value("2683259").for(:coach_cell)
	# should_not allow_value("14122683259").for(:coach_cell)
	# should_not allow_value("4122683259x224").for(:coach_cell)
	# should_not allow_value("800-EAT-FOOD").for(:coach_cell)
	# should_not allow_value("412/268/3259").for(:coach_cell)
	# should_not allow_value("412-2683-259").for(:coach_cell)

	# # tests for assistant_coach_cell
	# should allow_value("4122683259").for(:assistant_coach_cell)
	# should allow_value("412-268-3259").for(:assistant_coach_cell)
	# should allow_value("412.268.3259").for(:assistant_coach_cell)
	# should allow_value("(412) 268-3259").for(:assistant_coach_cell)
	# should allow_value(nil).for(:assistant_coach_cell)
	# should_not allow_value("2683259").for(:assistant_coach_cell)
	# should_not allow_value("14122683259").for(:assistant_coach_cell)
	# should_not allow_value("4122683259x224").for(:assistant_coach_cell)
	# should_not allow_value("800-EAT-FOOD").for(:assistant_coach_cell)
	# should_not allow_value("412/268/3259").for(:assistant_coach_cell)
	# should_not allow_value("412-2683-259").for(:assistant_coach_cell)

	# # tests for coach_email
	# should allow_value("fred@fred.com").for(:coach_email)
	# should allow_value("fred@andrew.cmu.edu").for(:coach_email)
	# should allow_value("my_fred@fred.org").for(:coach_email)
	# should allow_value("fred123@fred.gov").for(:coach_email)
	# should allow_value("my.fred@fred.net").for(:coach_email)
	# should_not allow_value("fred").for(:coach_email)
	# should_not allow_value("fred@fred,com").for(:coach_email)
	# should_not allow_value("fred@fred.uk").for(:coach_email)
	# should_not allow_value("my fred@fred.com").for(:coach_email)
	# should_not allow_value("fred@fred.con").for(:coach_email)

	# # tests for assistant_coach_email
	# should allow_value("fred@fred.com").for(:assistant_coach_email)
	# should allow_value("fred@andrew.cmu.edu").for(:assistant_coach_email)
	# should allow_value("my_fred@fred.org").for(:assistant_coach_email)
	# should allow_value("fred123@fred.gov").for(:assistant_coach_email)
	# should allow_value("my.fred@fred.net").for(:assistant_coach_email)
	# should_not allow_value("fred").for(:assistant_coach_email)
	# should_not allow_value("fred@fred,com").for(:assistant_coach_email)
	# should_not allow_value("fred@fred.uk").for(:assistant_coach_email)
	# should_not allow_value("my fred@fred.com").for(:assistant_coach_email)
	# should_not allow_value("fred@fred.con").for(:assistant_coach_email)



end
