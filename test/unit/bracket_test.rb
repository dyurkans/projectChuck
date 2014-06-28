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

    	should "restrict a brackets ages to 7-18" do
    		@badBracket = FactoryGirl.build(:bracket, tournament: @tourn, min_age: 5, max_age:7)
    		@badBracket2 = FactoryGirl.build(:bracket, tournament: @tourn, min_age:7, max_age:19)
       		@badBracket3 = FactoryGirl.build(:bracket, tournament: @tourn, min_age:nil, max_age:nil)
       		assert_equal true, @boys7to9.valid_age_limits
    		deny @badBracket.valid_age_limits
    		deny @badBracket2.valid_age_limits
    		deny @badBracket3.valid_age_limits
    	end

    	should "sum the total remaining spots in a bracket" do
    		assert_equal 9, @boys7to9.remaining_spots
    		assert_equal 7, @boys13to15.remaining_spots
    		# needs a test for 
    	end

    	should "sum the total number of students assigned to a teams on a specific bracket" do
    		assert_equal 1, @boys7to9.current_number_of_students
    		assert_equal 3, @boys13to15.current_number_of_students
    		@newBracket = FactoryGirl.create(:bracket, tournament:@tourn, min_age: 8, max_age: 12)
    		assert_equal 0, @newBracket.current_number_of_students
    		@newBracket.destroy
    	end

#This test could fail a a result of the age_as_of_june_1 method depending on the date on which you run this test. 
#If run before june 1st, results will be different. Correct, but will cause these tests to possibly fail.
    	should "provide a list of eligible unnassigned students for a specific bracket" do
    		@newStu = FactoryGirl.create(:student, household: @bam, first_name: "Julie", last_name: "Henderson", gender: false, medications: "insulin", dob: Date.new(17.years.ago.year,8,1), grade_integer: 13, email: "newStu@example.com")
    		@newReg = FactoryGirl.create(:registration, student: @newStu, team: nil)
    		@newStu2 = FactoryGirl.create(:student, household: @bam, first_name: "Julie", last_name: "Henderson", gender: false, medications: "insulin", dob: Date.new(17.years.ago.year,8,1), grade_integer: 13, email: "newStu2@example.com")
    		@newReg2 = FactoryGirl.create(:registration, student: @newStu2, team: nil)
    		assert_equal [@newStu, @newStu2], @youngwomen.eligible_students
    		assert_equal [], @boys7to9.eligible_students
    		@newStu.destroy
    		@newReg.destroy
    		@newStu2.destroy
    		@newReg2.destroy
    	end

#This test could fail a a result of the age_as_of_june_1 method depending on the date on which you run this test. 
#If run before june 1st, results will be different. Correct, but will cause these tests to possibly fail.
    	should "provide list of eligible students for a bracket, w/o regards to the gender of bracket" do
    		@newStu = FactoryGirl.create(:student, household: @bam, first_name: "Julie", last_name: "Henderson", gender: true, medications: "insulin", dob: Date.new(17.years.ago.year,8,1), grade_integer: 13, email: "newStu@example.com")
    		@newReg = FactoryGirl.create(:registration, student: @newStu, team: nil)
    		@newStu2 = FactoryGirl.create(:student, household: @bam, first_name: "Julie", last_name: "Henderson", gender: false, medications: "insulin", dob: Date.new(17.years.ago.year,8,1), grade_integer: 13, email: "newStu2@example.com")
    		@newReg2 = FactoryGirl.create(:registration, student: @newStu2, team: nil)
    		@newStu3 = FactoryGirl.create(:student, household: @mill, first_name: "Julie", last_name: "Henderson", gender: false, medications: "insulin", dob: Date.new(16.years.ago.year,8,1), grade_integer: 13, email: "newStu3@example.com")
    		@inactiveReg3 = FactoryGirl.create(:registration, student: @newStu3, team: nil, active: false)
   			@emptyBracket = FactoryGirl.create(:bracket, tournament: @tourn, min_age: 7, max_age: 7)
   			assert_equal [@julie, @newStu, @newStu2], @boys16to18.old_all_eligible_students
   			assert_equal [], @emptyBracket.old_all_eligible_students
    		@newStu.destroy
    		@newReg.destroy
    		@newStu2.destroy
    		@newReg2.destroy
    		@newStu3.destroy
    		@inactiveReg3.destroy
    		@emptyBracket.destroy
    	end

#This test could fail a a result of the age_as_of_june_1 method depending on the date on which you run this test. 
#If run before june 1st, results will be different. Correct, but will cause these tests to possibly fail.
    	should "provide a list of eligible students, both assigned and unassigned, for a specific bracket" do
    		@newStu = FactoryGirl.create(:student, household: @bam, first_name: "Julie", last_name: "Henderson", gender: true, medications: "insulin", dob: Date.new(17.years.ago.year,8,1), grade_integer: 13, email: "newStu@example.com")
    		@newReg = FactoryGirl.create(:registration, student: @newStu, team: nil)
    		@newStu2 = FactoryGirl.create(:student, household: @bam, first_name: "Julie", last_name: "Henderson", gender: false, medications: "insulin", dob: Date.new(17.years.ago.year,8,1), grade_integer: 13, email: "newStu2@example.com")
    		@newReg2 = FactoryGirl.create(:registration, student: @newStu2, team: nil)
    		@newStu3 = FactoryGirl.create(:student, household: @mill, first_name: "Julie", last_name: "Henderson", gender: true, medications: "insulin", dob: Date.new(16.years.ago.year,8,1), grade_integer: 13, email: "newStu3@example.com")
    		@inactiveReg3 = FactoryGirl.create(:registration, student: @newStu3, team: nil, active: false)
    		assert_equal [@newStu], @boys16to18.all_eligible_students
    		assert_equal [@fred, @ned], @boys10to12.all_eligible_students
    		assert_equal [@julie, @newStu2], @youngwomen.all_eligible_students
    		@newStu.destroy
    		@newReg.destroy
    		@newStu2.destroy
    		@newReg2.destroy
    		@newStu3.destroy
    		@inactiveReg3.destroy
    	end

	end

end
