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

	# tests for cell_phone
	should allow_value("4122683259").for(:cell_phone)
	should allow_value("412-268-3259").for(:cell_phone)
	should allow_value("412.268.3259").for(:cell_phone)
	should allow_value("(412) 268-3259").for(:cell_phone)
	should allow_value(nil).for(:cell_phone)
	should_not allow_value("2683259").for(:cell_phone)
	should_not allow_value("14122683259").for(:cell_phone)
	should_not allow_value("4122683259x224").for(:cell_phone)
	should_not allow_value("800-EAT-FOOD").for(:cell_phone)
	should_not allow_value("412/268/3259").for(:cell_phone)
	should_not allow_value("412-2683-259").for(:cell_phone)

	#test for family physician
	should validate_presence_of(:family_physician)

	#tests for insurance policy number
	should validate_presence_of(:insurance_policy_no)

	#tests for insurance provider
	should validate_presence_of(:insurance_provider)

	# tests for active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)


	 # Still need should matchers for these :family_physician, :home_phone, :insurance_policy_no, :insurance_provider, :physician_phone

end
