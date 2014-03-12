require 'test_helper'

class StudentTest < ActiveSupport::TestCase

	#Relationshiop validations
	should belong_to (:household)
	should have_many(:registrations)
	should have_one(:team).through(:registrations)

	#test first_name
 	should validate_presence_of(:first_name)

	#test last_name
 	should validate_presence_of(:last_name)

	# test dob
	should allow_value(29.years.ago.to_date).for(:dob)
	should allow_value(19.years.ago.to_date).for(:dob)
	should allow_value(14.years.ago.to_date).for(:dob)
	should allow_value(9.years.ago.to_date).for(:dob)
	should allow_value(5.years.ago.to_date).for(:dob)
	should_not allow_value(4.years.ago).for(:dob)
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

	#test gender
	should allow_value(true).for(:gender)
	should allow_value(false).for(:gender)
	should_not allow_value(nil).for(:gender)

	# test active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

end
