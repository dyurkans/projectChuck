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

	# tests for day_phone
	should allow_value("4122683259").for(:day_phone)
	should allow_value("412-268-3259").for(:day_phone)
	should allow_value("412.268.3259").for(:day_phone)
	should allow_value("(412) 268-3259").for(:day_phone)
	should allow_value(nil).for(:day_phone)
	should_not allow_value("2683259").for(:day_phone)
	should_not allow_value("14122683259").for(:day_phone)
	should_not allow_value("4122683259x224").for(:day_phone)
	should_not allow_value("800-EAT-FOOD").for(:day_phone)
	should_not allow_value("412/268/3259").for(:day_phone)
	should_not allow_value("412-2683-259").for(:day_phone)	  

	# test receive_texts
	should allow_value(true).for(:receive_texts)
	should allow_value(false).for(:receive_texts)
	should_not allow_value(nil).for(:receive_texts)

	# tests for email
	should validate_uniqueness_of(:email).case_insensitive
	should allow_value("fred@fred.com").for(:email)
	should allow_value("fred@andrew.cmu.edu").for(:email)
	should allow_value("my_fred@fred.org").for(:email)
	should allow_value("fred123@fred.gov").for(:email)
	should allow_value("my.fred@fred.net").for(:email)
	should_not allow_value("fred").for(:email)
	should_not allow_value("fred@fred,com").for(:email)
	should_not allow_value("fred@fred.uk").for(:email)
	should_not allow_value("my fred@fred.com").for(:email)
	should_not allow_value("fred@fred.con").for(:email)

	#test gender
	should allow_value(true).for(:gender)
	should allow_value(false).for(:gender)
	should_not allow_value(nil).for(:gender)

	# test active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

end
