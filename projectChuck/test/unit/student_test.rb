require 'test_helper'

class StudentTest < ActiveSupport::TestCase

	#Relationshiop validations
	should belong_to (:household)
	should have_many(:registrations)
	should have_many(:teams).through(:registrations)

	#test first_name
 	should validate_presence_of(:first_name)

	#test last_name
 	should validate_presence_of(:last_name)

	# test dob
	should_not allow_value(19.years.ago.to_date).for(:dob)
	should allow_value(18.years.ago.to_date).for(:dob)
	should allow_value(14.years.ago.to_date).for(:dob)
	should allow_value(9.years.ago.to_date).for(:dob)
	should allow_value(7.years.ago.to_date).for(:dob)
	should_not allow_value(5.years.ago).for(:dob)
	should_not allow_value("bad").for(:dob)
	should_not allow_value(nil).for(:dob)

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

	#test emergency_contact_name
 	should validate_presence_of(:emergency_contact_name)

	# tests for emergency_contact_phone
	should allow_value("4122683259").for(:emergency_contact_phone)
	should allow_value("412-268-3259").for(:emergency_contact_phone)
	should allow_value("412.268.3259").for(:emergency_contact_phone)
	should allow_value("(412) 268-3259").for(:emergency_contact_phone)
	should allow_value(nil).for(:emergency_contact_phone)
	should_not allow_value("2683259").for(:emergency_contact_phone)
	should_not allow_value("14122683259").for(:emergency_contact_phone)
	should_not allow_value("4122683259x224").for(:emergency_contact_phone)
	should_not allow_value("800-EAT-FOOD").for(:emergency_contact_phone)
	should_not allow_value("412/268/3259").for(:emergency_contact_phone)
	should_not allow_value("412-2683-259").for(:emergency_contact_phone)

	#test grade

	####This should probably be stored as an int and changed appropriately

	should allow_value("3").for(:grade_integer)
	should allow_value("12".for(:grade_integer)
	should allow_value("Sixth".for(:grade_integer)
	should_not allow_value(0.for(:grade_integer)
	should_not allow_value(nil.for(:grade_integer)

	#test gender
	should allow_value(true).for(:gender)
	should allow_value(false).for(:gender)
	should_not allow_value(nil).for(:gender)

	#test household_id
	should validate_numericality_of(:household_id)
	should_not allow_value(3.14159).for(:household_id)
	should_not allow_value(0).for(:household_id)
	should_not allow_value(-1).for(:household_id)

	#test for school
	should validate_presence_of(:school)

	#test for school_county
	should validate_presence_of(:school_county)

	#test for allergies

	#test for birth_certificate
	should validate_presence_of(:birth_certificate)
	#more

	#test for medications
	should allow_value(nil).for(:medications)
	#more

	#test for security_question
	should validate_presence_of(:security_question)
	#more

	#test for security_response
	should validate_presence_of(:security_response)
	#more

	# test active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

end
