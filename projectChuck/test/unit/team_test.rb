require 'test_helper'

class TeamTest < ActiveSupport::TestCase

	#Relationship Validations
	should belong_to(:bracket)
	should have_many(:registrations)

	#test max students
	should allow_value(10).for(:max_students)
	should_not allow_value(8).for(:max_students)
	should_not allow_value(nil).for(:max_students)

	#test name
	should validate_presence_of(:name)

	#test bracket id
	should validate_numericality_of(:bracket_id)
	should_not allow_value(3.14159).for(:bracket_id)
	should_not allow_value(0).for(:bracket_id)
	should_not allow_value(-1).for(:bracket_id)

end
