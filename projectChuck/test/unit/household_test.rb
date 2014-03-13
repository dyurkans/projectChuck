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

	# tests for home_phone
	should allow_value("4122683259").for(:home_phone)
	should allow_value("412-268-3259").for(:home_phone)
	should allow_value("412.268.3259").for(:home_phone)
	should allow_value("(412) 268-3259").for(:home_phone)
	should allow_value(nil).for(:home_phone)
	should_not allow_value("2683259").for(:home_phone)
	should_not allow_value("14122683259").for(:home_phone)
	should_not allow_value("4122683259x224").for(:home_phone)
	should_not allow_value("800-EAT-FOOD").for(:home_phone)
	should_not allow_value("412/268/3259").for(:home_phone)
	should_not allow_value("412-2683-259").for(:home_phone)

	#test for family physician
	should validate_presence_of(:family_physician)
	should allow_value("Dr. John Doe").for(:family_physician)
	should allow_value("John Doe").for(:family_physician)
	should allow_value("Dr John Doe").for(:family_physician)
	should allow_value("John Doe, M.D.").for(:family_physician)
	should allow_value("john doe").for(:family_physician)
	should_not allow_value("John").for(:family_physician)
	should_not allow_value(12345).for(:family_physician)
	should_not allow_value(nil).for(:family_physician)
	should_not allow_value("800-EAT-FOOD").for(:family_physician)

	#tests for insurance policy number
	should validate_presence_of(:insurance_policy_no)
	should allow_value("1234567890").for(:insurance_policy_no)
	should allow_value("Ad34134r44").for(:insurance_policy_no)
	should allow_value("QWERTYUIOO").for(:insurance_policy_no)
	should_not allow_value(nil).for(:insurance_policy_no)
	should_not allow_value(1345678902).for(:insurance_policy_no)

	#tests for insurance provider
	should validate_presence_of(:insurance_provider)

	# tests for physician_phone
	should allow_value("4122683259").for(:physician_phone)
	should allow_value("412-268-3259").for(:physician_phone)
	should allow_value("412.268.3259").for(:physician_phone)
	should allow_value("(412) 268-3259").for(:physician_phone)
	should allow_value(nil).for(:physician_phone)
	should_not allow_value("2683259").for(:physician_phone)
	should_not allow_value("14122683259").for(:physician_phone)
	should_not allow_value("4122683259x224").for(:physician_phone)
	should_not allow_value("800-EAT-FOOD").for(:physician_phone)
	should_not allow_value("412/268/3259").for(:physician_phone)
	should_not allow_value("412-2683-259").for(:physician_phone)

	# tests for active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

end
