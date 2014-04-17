require 'test_helper'

class BracketTest < ActiveSupport::TestCase

	#Relationship Validations
	should have_many(:teams)
	#next iteration //should belong_to(:tournament)

	#test gender
	should allow_value(true).for(:gender)
	should allow_value(false).for(:gender)
	should_not allow_value(nil).for(:gender)

	#test min_age
	should validate_numericality_of(:min_age)
	should allow_value(7).for(:min_age)
	should allow_value(18).for(:min_age)
	should_not allow_value("10").for(:min_age)
	should_not allow_value(nil).for(:min_age)
	should_not allow_value("twelve").for(:min_age)

	#test max_age
	should validate_numericality_of(:max_age)
	should allow_value(7).for(:max_age)
	should allow_value(18).for(:max_age)
	should_not allow_value("10").for(:max_age)
	should_not allow_value(nil).for(:max_age)
	should_not allow_value("twelve").for(:max_age)

	#test tournament_id
	should validate_numericality_of(:tournament_id)
	should_not allow_value(3.14159).for(:tournament_id)
	should_not allow_value(0).for(:tournament_id)
	should_not allow_value(-1).for(:tournament_id)

end
