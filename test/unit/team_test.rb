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

end
