require 'test_helper'

class TournamentTest < ActiveSupport::TestCase

	#Validate Relationships
	should have_many(:brackets)

	#test start_date
	should allow_value(2.years.ago.to_date).for(:start_date)
	should allow_value(1.year.ago.to_date).for(:start_date)
	should allow_value(8.months.ago.to_date).for(:start_date)
	should allow_value(1.month.from_now.to_date).for(:start_date)
	should_not allow_value("bad").for(:start_date)
	should_not allow_value(3).for(:start_date)

	#test end_date
	should allow_value(2.years.ago.to_date).for(:end_date)
	should allow_value(1.year.ago.to_date).for(:end_date)
	should allow_value(8.months.ago.to_date).for(:end_date)
	should allow_value(3.month.from_now.to_date).for(:end_date)
	should_not allow_value("bad").for(:end_date)
	should_not allow_value(3).for(:end_date)

	#Unit tests
	context "Creating tournament context" do
		setup do
			create_tournament_context
		end

		teardown do
			remove_tournament_context
		end

		should "end date must be later than start date" do
		    @tourn4 = FactoryGirl.build(:tournament, start_date: 10.weeks.from_now.to_date, end_date: 10.weeks.from_now.to_date)
		    @tourn5 = FactoryGirl.build(:tournament, start_date: 10.weeks.from_now.to_date, end_date: 5.weeks.from_now.to_date)
			assert_equal true, @tourn.valid_dates
			assert_equal true, @tourn2.valid_dates
			assert_equal true, @tourn3.valid_dates
			deny @tourn4.valid_dates
			deny @tourn5.valid_dates
		end

		should "order by date" do
			assert_equal [@tourn3, @tourn2, @tourn], Tournament.by_date
			assert_equal false, Tournament.by_date == [@tourn3, @tourn, @tourn2]
			assert_equal false, Tournament.by_date == [@tourn]
		end
	end
end