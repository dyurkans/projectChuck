require 'test_helper'

class UserTest < ActiveSupport::TestCase

	#Relationshiop validations
	should belong_to(:guardian)


end
