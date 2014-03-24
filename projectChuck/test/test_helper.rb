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
    #14 y.o. Ed Gruberman (10th grade)
    @ed = FactoryGirl.create(:student)
    #14 y.o. Ted Gruberman (10th grade)
    @ted = FactoryGirl.create(:student, first_name: "Ted", cell_phone: "412-268-2323", school_county:"Philadelphia")
    #11 y.o. Fred Gruberman (7th grade)
    @fred = FactoryGirl.create(:student, first_name: "Fred", grade_integer:7, dob:11.years.ago.to_date, school_county:"Orange")
    #13 y.o. Ned Gruberman (10th grade)
    @ned = FactoryGirl.create(:student, first_name: "Ned", dob: 13.years.ago.to_date, school:"Maryland High School", school_county:"Prince George's")
    #9 y.o. Noah Ark (5th grade)
    @noah = FactoryGirl.create(:student, first_name: "Noah", last_name: "Ark", grade_integer:5, dob: 9.years.ago.to_date, emergency_contact_name: "Hannah Ark")
    #14 y.o. Howard Marcus (10th grade)
    @howard = FactoryGirl.create(:student, first_name: "Howard", last_name: "Marcus", dob:169.months.ago.to_date, emergency_contact_phone: "412-555-5555")
    #13 y.o Jen Hanson (10th grade)
    @jen = FactoryGirl.create(:student, first_name: "Jen", last_name: "Hanson", gender:false, allergies:"nuts,shrimp,lemons", dob: 167.months.ago.to_date, school_county:"Philadelphia")
    #16 y.o. Julie Henderson (10th grade)
    @julie = FactoryGirl.create(:student, first_name: "Julie", last_name: "Henderson", gender:false, medications:"insulin", dob: 874.weeks.ago.to_date)
    #10 y.o Jason Hoover (10th grade)
    @jason = FactoryGirl.create(:student, first_name: "Jason", last_name: "Hoover", gender: true, medications:"theophyline", active: false, grade_integer: 6, dob: 10.years.ago.to_date)
  end
    
  def remove_student_context
    @ed.delete
    @ted.delete
    @fred.delete
    @ned.delete
    @noah.delete
    @jen.delete
    @howard.delete
    @julie.delete
    @jason.delete
  end

  def create_registration_context

  end 

  def remove_registration_context

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
    #40 y.o. Mary Gruberman
    @mary = FactoryGirl.create(:guardian)
    #45 y.o. Eric Gruberman
    @eric = FactoryGirl.create(:guardian, first_name:"Eric", dob:45.years.ago.to_date, cell_phone:"412-666-7890")
    #28 y.o. Alexandra Mill
    @alex = FactoryGirl.create(:guardian, first_name: "Alexandra", last_name:"Mill", dob:28.years.ago.to_date, cell_phone:nil, day_phone:"412-281-8080")
    #20 y.o. Leo Sutherland
    @leo = FactoryGirl.create(:guardian, first_name:"Leo", last_name:"Sutherland", dob:20.years.ago.to_date, receive_texts:false)
    #37 y.o. James Bambridge
    @james = FactoryGirl.create(:guardian, first_name: "James", last_name:"Bambridge", dob: 1982.weeks.ago.to_date, email:"james@hotmail.com", active:false)
  end

  def remove_guardian_context
    @mary.destroy
    @eric.destroy
    @alex.destroy
    @leo.destroy
    @james.destroy
  end

  def create_user_context

  end

  def remove_user_context

  end
end
