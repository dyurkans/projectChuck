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
    @eric = FactoryGirl.create(:guardian, household: @grub, first_name:"Eric", email: "eric.grub@gmail.com", cell_phone:"412-666-7890")
    #28 y.o. Alexandra Mill
    @alex = FactoryGirl.create(:guardian, household: @mill, first_name: "Alexandra", last_name:"Mill", email: "amill@yahoo.com", cell_phone:nil, day_phone:"412-281-8080")
    #20 y.o. Leo Sutherland
    @leo = FactoryGirl.create(:guardian, household: @suth, first_name:"Leo", last_name:"Sutherland", email: "leoSuth@andrew.cmu.edu", receive_texts:false)
    #37 y.o. James Bambridge
    @james = FactoryGirl.create(:guardian, household: @bam, first_name: "James", last_name:"Bambridge", email:"james@hotmail.com", active:false)
  end

  def remove_guardian_context
    @mary.destroy
    @eric.destroy
    @alex.destroy
    @leo.destroy
    @james.destroy
  end

  def create_student_context
    #13 y.o. Ed Gruberman (10th grade)
    @ed = FactoryGirl.create(:student, household_id: @grub.id, email: "ed@example.com")
    #13 y.o. Ted Smog (10th grade)
    @ted = FactoryGirl.create(:student, household_id: @grub.id, first_name: "Ted", last_name: "Smog", cell_phone: "412-268-2323", school_county: 0, email: "ted@example.com")
    #10 y.o. Fred Applehouse (7th grade)
    @fred = FactoryGirl.create(:student, household_id: @grub.id, first_name: "Fred", last_name: "Applehouse", grade_integer:7, dob: Date.new(11.years.ago.year,8,1), school_county: 13, email: "fred@example.com")
    #12 y.o. Ned Staton (10th grade)
    @ned = FactoryGirl.create(:student, household_id: @grub.id, first_name: "Ned", last_name: "Staton", dob: Date.new(13.years.ago.year, 8, 1), school:"Maryland High School", school_county: 24, email: "ned@example.com")
    #8 y.o. Noah Ark (5th grade)
    @noah = FactoryGirl.create(:student, household_id: @mill.id, first_name: "Noah", last_name: "Ark", grade_integer:5, dob: Date.new(9.years.ago.year, 8, 1), emergency_contact_name: "Hannah Ark", email: "noah@example.com")
    #13 y.o. Howard Marcus (10th grade)
    @howard = FactoryGirl.create(:student, household_id: @mill.id, first_name: "Howard", last_name: "Marcus", dob: Date.new(14.years.ago.year, 8, 1), emergency_contact_phone: "412-555-5555", email: "howard@example.com")
    #12 y.o Jen Hanson (10th grade)
    @jen = FactoryGirl.create(:student, household_id: @mill.id, first_name: "Jen", last_name: "Hanson", gender: false, allergies: "nuts,shrimp,lemons", dob: Date.new(13.years.ago.year, 8, 1), school_county: 4, email: "jen@example.com")
    #17 y.o. Julie Henderson (Senior)
    @julie = FactoryGirl.create(:student, household_id: @bam.id, first_name: "Julie", last_name: "Henderson", gender: false, medications: "insulin", dob: Date.new(18.years.ago.year, 8, 1), grade_integer: 13, email: "julie@example.com")
    #9 y.o Jason Hoover (6th grade)
    @jason = FactoryGirl.create(:student, household_id: @suth.id, first_name: "Jason", last_name: "Hoover", gender: true, medications: "theophyline", active: false, grade_integer:6, dob: Date.new(10.years.ago.year, 8, 1), email: "jason@example.com")
  end

  #Alphabetized by last name: @fred, @noah, @ed, @jen, @julie, @howard, @jason, @ted, @ned
  #Ordered by age and alphbetized: @noah, @jason, @fred, @jen, @ned, @ed, @howard, @ted, @julie 
  #Alphabetized by last name mapped by last name: "Applehouse", "Ark", "Gruberman", "Hanson", "Henderson", "Hoover", "Marcus", "Smog", "Staton"
  #Alphabetized by_school_district: @ted, @noah, @ed, @julie, @jason, @howard, @jen, @fred, @ned
  #Ordered by grade and alphabetized: @noah, @jason, @fred, @ed, @jen, @howard, @ted, @ned, @julie
  
  def remove_student_context
    @ed.destroy
    @ted.destroy
    @fred.destroy
    @ned.destroy
    @noah.destroy
    @howard.destroy
    @jen.destroy
    @julie.destroy
    @jason.destroy
  end

  def create_tournament_context
    @tourn = FactoryGirl.create(:tournament)
    @tourn2 = FactoryGirl.create(:tournament, start_date: 10.weeks.from_now.to_date, end_date: 15.weeks.from_now.to_date)
    @tourn3 = FactoryGirl.create(:tournament, start_date: 10.weeks.from_now.to_date, end_date: 18.weeks.from_now.to_date)
  end

  def remove_tournament_context
    @tourn.destroy
    @tourn2.destroy
    @tourn3.destroy
  end

  def create_bracket_context
    @boys7to9 = FactoryGirl.create(:bracket, tournament_id: @tourn.id, gender: true, min_age: 7, max_age: 9)
    @boys10to12 = FactoryGirl.create(:bracket, tournament_id: @tourn.id, gender: true, min_age: 10, max_age: 12)
    @boys13to15 = FactoryGirl.create(:bracket, tournament_id: @tourn.id, gender: true, min_age: 13, max_age: 15)
    @boys16to18 = FactoryGirl.create(:bracket, tournament_id: @tourn.id, gender: true, min_age: 16, max_age: 18)
    @littlegirls = FactoryGirl.create(:bracket, tournament_id: @tourn.id, gender: false, min_age: 7, max_age:12)
    @youngwomen = FactoryGirl.create(:bracket, tournament_id: @tourn.id, gender: false, min_age: 13, max_age: 18)
  end

  def remove_bracket_context
    @boys7to9.destroy
    @boys10to12.destroy
    @boys13to15.destroy
    @boys16to18.destroy
    @littlegirls.destroy
    @youngwomen.destroy
  end
  
  #IDs: 8,29,15,13,19,6
  def create_team_context 
    # Boys 7 to 9 team
    @pistons = FactoryGirl.create(:team, bracket_id: @boys7to9.id, name: 8)
    # Boys 10 to 12 team
    @wizards = FactoryGirl.create(:team, bracket_id: @boys10to12.id, name: 29)
    # Boys 13 to 15 team
    @heat = FactoryGirl.create(:team, bracket_id: @boys13to15.id, name: 15)
    # Boys 16 to 18 team
    @lakers = FactoryGirl.create(:team, bracket_id: @boys16to18.id, name: 13)
    # Little Girls team
    @knicks = FactoryGirl.create(:team, bracket_id: @littlegirls.id)
    # Young Women team
    @mavs = FactoryGirl.create(:team, bracket_id: @youngwomen.id, name: 6)
  end

  def remove_team_context
    @pistons.destroy
    @wizards.destroy
    @heat.destroy
    @lakers.destroy
    @knicks.destroy
    @mavs.destroy
  end

  def create_registration_context
    #ages: 13,13,10,12,8,13,12
    @reg1 = FactoryGirl.create(:registration, student_id: @ed.id, team_id: @heat.id)
    @reg2 = FactoryGirl.create(:registration, student_id: @ted.id, team_id: @heat.id)
    @reg3 = FactoryGirl.create(:registration, student_id: @fred.id, team_id: @wizards.id)
    @reg4 = FactoryGirl.create(:registration, student_id: @ned.id, team_id: @wizards.id)
    @reg5 = FactoryGirl.create(:registration, student_id: @noah.id, team_id: @pistons.id)
    @reg6 = FactoryGirl.create(:registration, student_id: @howard.id, team_id: @heat.id)
    @reg7 = FactoryGirl.create(:registration, student_id: @jen.id, team_id: @knicks.id)
    @reg8 = FactoryGirl.create(:registration, student_id: @julie.id, team_id: @mavs.id)
    @reg9 = FactoryGirl.create(:registration, student_id: @jason.id, team_id: @pistons.id)
  end 

  def remove_registration_context
    @reg1.destroy
    @reg2.destroy
    @reg3.destroy
    @reg4.destroy
    @reg5.destroy
    @reg6.destroy
    @reg7.destroy
    @reg8.destroy
    @reg9.destroy
  end

  def create_user_context

  end

  def remove_user_context

  end
end
