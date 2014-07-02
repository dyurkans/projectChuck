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
	should_not allow_value(nil).for(:zip)
	should_not allow_value("bad").for(:zip)
	should_not allow_value("1512").for(:zip)
	should_not allow_value("152134").for(:zip)
	should_not allow_value("15213-0983").for(:zip)

	# tests for state
	should allow_value("OH").for(:state)
	should allow_value("PA").for(:state)
	should allow_value("WV").for(:state)
	should allow_value("NY").for(:state)
	should allow_value("CA").for(:state)	
	should_not allow_value("bad").for(:state)
	should_not allow_value(10).for(:state)

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
	should allow_value("Dr. John Doe").for(:family_physician)
	should allow_value("John Doe").for(:family_physician)
	should allow_value("Dr John Doe").for(:family_physician)
	should allow_value("John Doe, M.D.").for(:family_physician)
	should allow_value("john doe").for(:family_physician)
	should allow_value("John").for(:family_physician)	
	should allow_value(nil).for(:family_physician)	
	should_not allow_value(12345).for(:family_physician)

	#tests for insurance policy number
	should allow_value("1234567890").for(:insurance_policy_no)
	should allow_value("Ad34134r44").for(:insurance_policy_no)
	should allow_value("QWERTYUIOO").for(:insurance_policy_no)
	should allow_value(nil).for(:insurance_policy_no)

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

	context "Creating a household context" do
	    setup do
			create_household_context
			create_guardian_context
			create_student_context
	    end
	      
	    teardown do
			remove_student_context
			remove_guardian_context
			remove_household_context
	    end

	    # quick test of factories
	    should "have working factories" do
	      #Households
	      @grub.valid?
	      @mill.valid?
	      @suth.valid?
	      @bam.valid?
	      #Guardians
	      @mary.valid?
	      @eric.valid?
	      @alex.valid?
	      @leo.valid?
	      @james.valid?
	      #Students
	      @ed.valid?
	      @ted.valid?
	      @fred.valid?
	      @ned.valid?
	      @noah.valid?
	      @howard.valid?
	      @jen.valid?
	      @julie.valid?
	      @jason.valid?
	    end

	    should "have a method to display the household's full street address" do
	    	assert_equal "5000 Forbes Avenue, Pittsburgh, PA 15213", @grub.full_address
	    	assert_equal "5514 Wilkins Ave, Pittsburgh, PA 15217", @mill.full_address
	    end

	    should "have a method to show the name of the household" do
	    	assert_equal "Eric Gruberman/Mary Gruberman", @grub.name
	    	assert_equal "Alexandra Mill", @mill.name
	    	@house = FactoryGirl.create(:household)
	    	assert_equal "5000 Forbes Avenue, Pittsburgh, PA 15213", @house.name
	    	@house.destroy
	    end

	    should "have working active scope" do
	    	@house = FactoryGirl.create(:household, active: false)
	    	assert_equal [@grub, @mill, @suth, @bam], Household.active
	    	@house2 = FactoryGirl.create(:household)
	    	assert_equal [@grub, @mill, @suth, @bam, @house2], Household.active
	    	@house.destroy
	    	@house2.destroy
	    end

	    should "have working inactive scope" do
	    	@house = FactoryGirl.create(:household, active: false)
	    	@house2 = FactoryGirl.create(:household, active: false)
	    	assert_equal [@house, @house2], Household.inactive
	    	@house.destroy
	    	@house2.destroy
	    end

	    should "order households by last name" do
	    	assert_equal [@bam, @grub, @mill, @suth], Household.by_last_name
	    end

	    should "strip non-digits from home phone and physician phone" do 
	      assert_equal "4122682323", @grub.home_phone
	      assert_equal "4125555555", @mill.physician_phone
	      deny @grub.home_phone == "(412) 268-2323"
	      deny @mill.physician_phone == "(412) 555-5555"
	    end

	    should "titleize text inputs" do
			@house = FactoryGirl.create(:household, street: "5000 forbes   AVE ", city: " PiTtsburgh", county: "Allegheny", family_physician: "DR. John  doe jr.", insurance_provider: nil)
			assert_equal "5000 Forbes Ave", @house.street
			assert_equal "Pittsburgh", @house.city
			assert_equal "Allegheny", @house.county
			assert_equal "Dr. John Doe Jr.", @house.family_physician
			assert_equal nil, @house.insurance_provider
	    end

	end

end
