ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  # Prof. H's deny method to improve readability of tests
  def deny(condition, msg="")
    # a simple transformation to increase readability IMO
    assert !condition, msg
  end
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_student_context
  	@ed = FactoryGirl.create(:student)
  end

  def remove_student_context
  	@ed.delete
  end

  def create_registration_context

  end 

  def remove_registration_context
  	@reg_ed.delete
  end

  def create_team_context

  end

  def remove_team_context

  end

  def create_bracket_context

  end

  def remove_bracket_context

  end

  def create_household_context

  end

  def remove_household_context

  end

  def create_guardian_context

  end

  def remove_guardian_context

  end

  def create_user_context

  end

  def remove_user_context

  end
end
