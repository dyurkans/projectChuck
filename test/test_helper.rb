require 'simplecov'
SimpleCov.start 'rails'
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

  # Add more helper methods to be used by all tests here...

  def create_household_context
    #Gruberman household, 4 Gruberman children
    @grub = FactoryGirl.create(:household)
    #Mill household, children Ark Marcus and Hanson
    @mill = FactoryGirl.create(:household, street: "5514 Wilkins Ave", zip: "15217")
    #Sutherland household
    @suth = FactoryGirl.create(:household, street: "1000 Morewood Ave")
    #Bambridge household, children Henderson and Hoover
    @bam = FactoryGirl.create(:household, street: "2 Main St")

  end

  def remove_household_context
    @grub.destroy
    @mill.destroy
    @suth.destroy
    @bam.destroy
  end

  def create_guardian_context
    #40 y.o. Mary Gruberman
    @mary = FactoryGirl.create(:guardian, household: @grub)
    #45 y.o. Eric Gruberman
    @eric = FactoryGirl.create(:guardian, household: @grub, first_name:"Eric", email: "eric.grub@gmail.com", dob:45.years.ago.to_date, cell_phone:"412-666-7890")
    #28 y.o. Alexandra Mill
    @alex = FactoryGirl.create(:guardian, household: @mill, first_name: "Alexandra", last_name:"Mill", email: "amill@yahoo.com", dob:28.years.ago.to_date, cell_phone:nil, day_phone:"412-281-8080")
    #20 y.o. Leo Sutherland
    @leo = FactoryGirl.create(:guardian, household: @suth, first_name:"Leo", last_name:"Sutherland", email: "leoSuth@andrew.cmu.edu", dob:20.years.ago.to_date, receive_texts:false)
    #37 y.o. James Bambridge
    @james = FactoryGirl.create(:guardian, household: @bam, first_name: "James", last_name:"Bambridge", dob: 1982.weeks.ago.to_date, email:"james@hotmail.com", active:false)
  end

  def remove_guardian_context
    @mary.destroy
    @eric.destroy
    @alex.destroy
    @leo.destroy
    @james.destroy
  end

  def create_student_context
    #14 y.o. Ed Gruberman (10th grade)
    @ed = FactoryGirl.create(:student, household: @grub, email: "ed@example.com")
    #14 y.o. Ted Gruberman (10th grade)
    @ted = FactoryGirl.create(:student, household: @grub, first_name: "Ted", cell_phone: "412-268-2323", school_county:"Philadelphia", email: "ted@example.com")
    #11 y.o. Fred Gruberman (7th grade)
    @fred = FactoryGirl.create(:student, household: @grub, first_name: "Fred", grade_integer:7, dob:11.years.ago.to_date, school_county:"Orange", email: "fred@example.com")
    #13 y.o. Ned Gruberman (10th grade)
    @ned = FactoryGirl.create(:student, household: @grub, first_name: "Ned", dob: 13.years.ago.to_date, school:"Maryland High School", school_county:"Prince George's", email: "ned@example.com")
    #9 y.o. Noah Ark (5th grade)
    @noah = FactoryGirl.create(:student, household: @mill, first_name: "Noah", last_name: "Ark", grade_integer:5, dob: 9.years.ago.to_date, emergency_contact_name: "Hannah Ark", email: "noah@example.com")
    #14 y.o. Howard Marcus (10th grade)
    @howard = FactoryGirl.create(:student, household: @mill, first_name: "Howard", last_name: "Marcus", dob:169.months.ago.to_date, emergency_contact_phone: "412-555-5555", email: "howard@example.com")
    #13 y.o Jen Hanson (10th grade)
    @jen = FactoryGirl.create(:student, household: @mill, first_name: "Jen", last_name: "Hanson", gender: false, allergies: "nuts,shrimp,lemons", dob: 167.months.ago.to_date, school_county:"Philadelphia", email: "jen@example.com")
    #18 y.o. Julie Henderson (10th grade)
    @julie = FactoryGirl.create(:student, household: @bam, first_name: "Julie", last_name: "Henderson", gender: false, medications: "insulin", dob: 941.weeks.ago.to_date, grade_integer: 13, email: "julie@example.com")
    #10 y.o Jason Hoover (6th grade)
    @jason = FactoryGirl.create(:student, household: @suth, first_name: "Jason", last_name: "Hoover", gender: true, medications: "theophyline", active: false, grade_integer:6, dob: 10.years.ago.to_date, email: "jason@example.com")
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

  def create_tournament_context
    @tourn = FactoryGirl.create(:tournament)
    @tourn2 = FactoryGirl.create(:tournament, start_date: 10.weeks.from_now.to_date, end_date: 15.weeks.from_now.to_date)
    @tourn3 = FactoryGirl.create(:tournament, start_date: 10.weeks.from_now.to_date, end_date: 18.weeks.from_now.to_date)
  end

  def remove_tournament_context
    @tourn.delete
    @tourn2.delete
    @tourn3.delete
  end

  def create_bracket_context
    @boys7to9 = FactoryGirl.create(:bracket, tournament: @tourn, gender: true, min_age: 7, max_age: 9)
    @boys10to12 = FactoryGirl.create(:bracket, tournament: @tourn, gender: true, min_age: 10, max_age: 12)
    @boys13to15 = FactoryGirl.create(:bracket, tournament: @tourn, gender: true, min_age: 13, max_age: 15)
    @boys16to18 = FactoryGirl.create(:bracket, tournament: @tourn, gender: true, min_age: 16, max_age: 18)
    @littlegirls = FactoryGirl.create(:bracket, tournament: @tourn, gender: false, min_age: 7, max_age:12)
    @youngwomen = FactoryGirl.create(:bracket, tournament: @tourn, gender: false, min_age: 13, max_age: 18)
  end

  def remove_bracket_context
    @boys7to9.delete
    @boys10to12.delete
    @boys13to15.delete
    @boys16to18.delete
    @littlegirls.delete
    @youngwomen.delete
  end

  def create_team_context
    # Boys 7 to 9 team
    @pistons = FactoryGirl.create(:team, bracket: @boys7to9, name: "Detroit Pistons")
    # Boys 10 to 12 team
    @wizards = FactoryGirl.create(:team, bracket: @boys10to12, name: "Washington Wizards")
    # Boys 13 to 15 team
    @heat = FactoryGirl.create(:team, bracket: @boys13to15, name: "Miami Heat")
    # Boys 16 to 18 team
    @lakers = FactoryGirl.create(:team, bracket: @boys16to18, name: "Los Angeles Lakers")
    # Little Girls team
    @knicks = FactoryGirl.create(:team, bracket: @littlegirls, name: "New York Knicks")
    # Young Women team
    @mavs = FactoryGirl.create(:team, bracket: @youngwomen, name: "Dallas Mavericks")
  end

  def remove_team_context
    @pistons.delete
    @wizards.delete
    @heat.delete
    @lakers.delete
    @knicks.delete
    @mavs.delete
  end

  def create_registration_context
    @reg1 = FactoryGirl.create(:registration, student: @ed, team: @heat)
    @reg2 = FactoryGirl.create(:registration, student: @ted, team: @heat)
    @reg3 = FactoryGirl.create(:registration, student: @fred, team: @wizards)
    @reg4 = FactoryGirl.create(:registration, student: @ned, team: @heat)
    @reg5 = FactoryGirl.create(:registration, student: @noah, team: @pistons)
    @reg6 = FactoryGirl.create(:registration, student: @howard, team: @heat)
    @reg7 = FactoryGirl.create(:registration, student: @jen, team: @mavs)
    @reg8 = FactoryGirl.create(:registration, student: @julie, team: @mavs)
    @reg9 = FactoryGirl.create(:registration, student: @jason, team: @wizards)
  end 

  def remove_registration_context
    @reg1.delete
    @reg2.delete
    @reg3.delete
    @reg4.delete
    @reg5.delete
    @reg6.delete
    @reg7.delete
    @reg8.delete
    @reg9.delete
  end

  def create_user_context

  end

  def remove_user_context

  end
end
