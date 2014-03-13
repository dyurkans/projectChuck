require 'test_helper'

class HouseholdTest < ActiveSupport::TestCase	

	#Realtionship Validations
	should have_many(:students)
	should have_many(:guardians)

	# tests for street
	should validate_presence_of(:street)

	# tests for city
	should validate_presence_of(:city)  

	# tests for zip
	should allow_value("15213").for(:zip)
	should_not allow_value("bad").for(:zip)
	should_not allow_value("1512").for(:zip)
	should_not allow_value("152134").for(:zip)
	should_not allow_value("15213-0983").for(:zip)

	# tests for state
	should allow_value("OH").for(:state)
	should allow_value("PA").for(:state)
	should allow_value("WV").for(:state)
	should_not allow_value("bad").for(:state)
	should allow_value("NY").for(:state)
	should_not allow_value(10).for(:state)
	should allow_value("CA").for(:state)

	# tests for active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

end
