require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase

	#relationship validations
	should belong_to(:student)
	should belong_to(:team)

	# test active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

	#test student_id
	should validate_numericality_of(:student_id)
	should_not allow_value(3.14159).for(:student_id)
	should_not allow_value(0).for(:student_id)
	should_not allow_value(-1).for(:student_id)

	#test team_id
	should validate_numericality_of(:team_id)
	should_not allow_value(3.14159).for(:team_id)
	should_not allow_value(0).for(:team_id)
	should_not allow_value(-1).for(:team_id)

	#test date

	#test physical

	#test physical date

	#test proof_of_insurance

	#test report_card

	#test t_shirt_size


end
