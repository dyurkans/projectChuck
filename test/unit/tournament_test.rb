require 'test_helper'

class TournamentTest < ActiveSupport::TestCase

	#Validate Relationships
	# should have_many(:brackets)

	# #test start_date
	# should allow_value(2.years.ago.to_date).for(:start_date)
	# should allow_value(1.year.ago.to_date).for(:start_date)
	# should allow_value(8.months.ago.to_date).for(:start_date)
	# should allow_value(1.month.from_now).for(:start_date)
	# should_not allow_value("bad").for(:start_date)
	# should_not allow_value(3).for(:start_date)

	# #test end_date
	# should allow_value(2.years.ago.to_date).for(:end_date)
	# should allow_value(1.year.ago.to_date).for(:end_date)
	# should allow_value(8.months.ago.to_date).for(:end_date)
	# should allow_value(3.month.from_now).for(:end_date)
	# should_not allow_value("bad").for(:end_date)
	# should_not allow_value(3).for(:end_date)

	#Unit tests
	context "Creating tournament context" do
		setup do
			create_tournament_context
		end

		teardown do
			remove_tournament_context
		end

	    # quick test of factories
	    should "have working factories" do
	      assert_equal 2.weeks.from_now, @tourn.start_date
	      assert_equal 10.weeks.from_now, @tourn2.start_date
	      assert_equal 10.weeks.from_now, @tourn3.start_date
	      assert_equal 18.weeks.from_now, @tourn3.end_date
	      deny 5.days.from_now, @tourn2
	    end

		# should "end date must be later than start date" do
		#     @tourn4 = FactoryGirl.create(:tournament, start_date: 10.weeks.from_now, end_date: 10.weeks.from_now)
		#     @tourn5 = FactoryGirl.create(:tournament, start_date: 10.weeks.from_now, end_date: 5.weeks.from_now)
		# 	assert_equal true, @tourn.validates_date
		# 	assert_equal true, @tourn2.validates_date
		# 	assert_equal true, @tourn3.validates_date
		# 	deny @tourn4.validates_date
		# 	deny @tourn5.validates_date
		# end

		# should "order by date" do
		# 	assert_equal [@tourn3, @tourn2, @tourn1], Tournament.by_date
		# 	deny [@tourn3, @tourn1, @tourn2], Tournament.by_date
		# 	deny [@tourn], Tournament.by_date
		# end
	end
end