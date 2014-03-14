require 'test_helper'

class TeamTest < ActiveSupport::TestCase

	#Relationship Validations
	should belong_to(:bracket)
	should have_many(:registrations)


end
