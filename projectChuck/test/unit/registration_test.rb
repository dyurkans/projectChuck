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

	#test physical

	#test physical date
	should_not allow_value(2.years.ago.to_date).for(:physical_date)
	#not sure about this, we need to check how recent physicals must be
	should allow_value(1.year.ago.to_date).for(:physical_date)
	should allow_value(8.months.ago.to_date).for(:physical_date)
	should_not allow_value(1.month.from_now).for(:physical_date)
	should_not allow_value("bad").for(:physical_date)

	#test proof_of_insurance

	#test report_card

	#test t_shirt_size
	#note that size 0=small, size 5=xxxl
	should validate_numericality_of(:t_shirt_size)
	should allow_value(0).for(:t_shirt_size)
	should allow_value(5).for(:t_shirt_size)
	should_not allow_value(-1).for(:t_shirt_size)
	should_not allow_value(6).for(:t_shirt_size)
	should_not allow_value(nil).for(:t_shirt_size)
	should_not allow_value("small").for(:t_shirt_size)

	context "Creating a registration context" do
	    setup do
			create_household_context
			create_guardian_context
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
			remove_guardian_context
			remove_household_context
	    end

	    should "allow a student to register for a team in the appropriate bracket" do
	    	@howard_reg = FactoryGirl.build(:registration, student: @howard, team: @heat)
	    	assert_equal true, @howard_reg.valid?
	    end

	    should "not allow a student to register for a team in the inappropriate bracket" do
	    	@howard_reg = FactoryGirl.build(:registration, student: @howard, team: @pistons)
	    	@jason_reg = FactoryGirl.build(:registration, student: @jason, team: @knicks)
	    	deny @howard_reg.valid?
	    	deny @jason_reg.valid?
	    end

	    should "not allow duplicate registrations" do
	    	@julie_reg2 = FactoryGirl.build(:registration, student: @julie, team: @pistons)
	    	deny @julie_reg2.valid?
	    end

	    should "have a method to show if registration is missing documents" do
	    	assert_equal true, @ed_reg2.missing_doc
	    	assert_equal true, @julie_reg.missing_doc
	    	assert_equal true, @noah_reg.missing_doc
	    	deny @ed_reg1.missing_doc
	    end

	    should "not allow a student to register if outside of the tournament's age range" do
	    	@young = FactoryGirl.build(:student, dob: 2.years.ago.to_date)
	    	@young_reg = FactoryGirl.build(:registration, student: @young)
	    	@old = FactoryGirl.build(:student, dob: 20.years.ago.to_date)
	    	@old_reg = FactoryGirl.build(:registration, student: @old)

	    	deny @young_reg.valid?
	    	deny @old_reg.valid?
	    end
	end

end
