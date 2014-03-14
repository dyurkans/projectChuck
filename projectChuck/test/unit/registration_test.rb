require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase

	#relationship validations
	should belong_to(:student)
	should belong_to(:team)

end
