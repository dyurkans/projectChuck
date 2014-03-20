require 'test_helper'

class UserTest < ActiveSupport::TestCase

	#Relationshiop validations
	should belong_to(:guardian)

	# test active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

	#test guardian id
	should validate_numericality_of(:guardian_id)
	should_not allow_value(3.14159).for(:guardian_id)
	should_not allow_value(0).for(:guardian_id)
	should_not allow_value(-1).for(:guardian_id)

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

	#tests for role
	should allow_value("admin").for(:role)
	#Currently only implementing one role. 
	#Expand to volunteer, guest, etc. in further iterations.
	should_not allow_value("volunteer").for(:role)
	should_not allow_value("bad").for(:role)
	should_not allow_value("hacker").for(:role)
	should_not allow_value(10).for(:role)
	should_not allow_value("leader").for(:role)
	should_not allow_value(nil).for(:role)


end
