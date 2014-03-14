require 'test_helper'

class BracketTest < ActiveSupport::TestCase

	#Relationship Validations
	should have_many(:teams)
	#next iteration //should belong_to(:tournament)

end
