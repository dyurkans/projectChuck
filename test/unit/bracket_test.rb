require 'test_helper'

class BracketTest < ActiveSupport::TestCase

	#Relationship Validations
	should have_many(:teams)
	should belong_to(:tournament)

	#test gender
	should allow_value(true).for(:gender)
	should allow_value(false).for(:gender)
	should_not allow_value(nil).for(:gender)

	#test min_age
	should validate_numericality_of(:min_age)
	should allow_value(7).for(:min_age)
	should allow_value(18).for(:min_age)
	#For some reason the shoulda matchers treat "10" as an int unless both sets of qoutes are used
	should_not allow_value("'10'").for(:min_age)
	should_not allow_value(nil).for(:min_age)
	should_not allow_value("twelve").for(:min_age)

	#test max_age
	should validate_numericality_of(:max_age)
	should allow_value(7).for(:max_age)
	should allow_value(18).for(:max_age)
	#For some reason the shoulda matchers treat "10" as an int unless both sets of qoutes are used
	should_not allow_value("'10'").for(:max_age)
	should_not allow_value(nil).for(:max_age)
	should_not allow_value("twelve").for(:max_age)

	#test tournament_id
	should validate_numericality_of(:tournament_id)
	should_not allow_value(3.14159).for(:tournament_id)
	should_not allow_value(0).for(:tournament_id)
	should_not allow_value(-1).for(:tournament_id)

	context "Creating a bracket context" do
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

	    should "have a method to display a bracket's gender as a string" do
      		assert_equal "Male", @boys7to9.sex
      		assert_equal "Female", @littlegirls.sex
    	end

    	should "have a method to display a bracket's name" do
    		assert_equal "Male 7 - 9", @boys7to9.name
    		assert_equal "Female 7 - 12", @littlegirls.name
    	end
	end

end
