require 'test_helper'

class GuardianTest < ActiveSupport::TestCase

	#Relationshiop validations
	should have_many(:users)
	should belong_to(:household)
	#next iteration //should have_many(:volunteers)

end
