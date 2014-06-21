# require 'test_helper'

# class StudentTest < ActiveSupport::TestCase

#   #Relationshiop validations
#   should belong_to (:household)
#   should have_many(:registrations)
#   should have_many(:teams).through(:registrations)

#   #test first_name
#   should validate_presence_of(:first_name)

#   #test last_name
#   should validate_presence_of(:last_name)

#   # test dob
#   should_not allow_value(19.years.ago.to_date).for(:dob)
#   should allow_value(18.years.ago.to_date).for(:dob)
#   should allow_value(14.years.ago.to_date).for(:dob)
#   should allow_value(9.years.ago.to_date).for(:dob)
#   should allow_value(7.years.ago.to_date).for(:dob)
#   should_not allow_value(5.years.ago).for(:dob)
#   should_not allow_value("bad").for(:dob)
#   should_not allow_value(nil).for(:dob)

#   # tests for cell_phone
#   should allow_value("4122683259").for(:cell_phone)
#   should allow_value("412-268-3259").for(:cell_phone)
#   should allow_value("412.268.3259").for(:cell_phone)
#   should allow_value("(412) 268-3259").for(:cell_phone)
#   should allow_value(nil).for(:cell_phone)
#   should_not allow_value("2683259").for(:cell_phone)
#   should_not allow_value("14122683259").for(:cell_phone)
#   should_not allow_value("4122683259x224").for(:cell_phone)
#   should_not allow_value("800-EAT-FOOD").for(:cell_phone)
#   should_not allow_value("412/268/3259").for(:cell_phone)
#   should_not allow_value("412-2683-259").for(:cell_phone)

#   #test emergency_contact_name
#   should validate_presence_of(:emergency_contact_name)

#   # tests for emergency_contact_phone
#   should allow_value("4122683259").for(:emergency_contact_phone)
#   should allow_value("412-268-3259").for(:emergency_contact_phone)
#   should allow_value("412.268.3259").for(:emergency_contact_phone)
#   should allow_value("(412) 268-3259").for(:emergency_contact_phone)
#   should_not allow_value(nil).for(:emergency_contact_phone)
#   should_not allow_value("2683259").for(:emergency_contact_phone)
#   should_not allow_value("14122683259").for(:emergency_contact_phone)
#   should_not allow_value("4122683259x224").for(:emergency_contact_phone)
#   should_not allow_value("800-EAT-FOOD").for(:emergency_contact_phone)
#   should_not allow_value("412/268/3259").for(:emergency_contact_phone)
#   should_not allow_value("412-2683-259").for(:emergency_contact_phone)

#   #test grade

#   ####This should probably be stored as an int and changed appropriately

#   should allow_value("3").for(:grade_integer)
#   should allow_value("12").for(:grade_integer)
#   should_not allow_value("Sixth").for(:grade_integer)
#   should_not allow_value(0).for(:grade_integer)
#   should_not allow_value(nil).for(:grade_integer)

#   #test gender
#   should allow_value(true).for(:gender)
#   should allow_value(false).for(:gender)
#   should_not allow_value(nil).for(:gender)

#   # #test household_id
#   # should validate_numericality_of(:household_id)
#   # should_not allow_value(3.14159).for(:household_id)
#   # should_not allow_value(0).for(:household_id)
#   # should_not allow_value(-1).for(:household_id)

#   #test for school
#   should validate_presence_of(:school)

#   #test for school_county
#   should validate_presence_of(:school_county)

#   #test for allergies

#   #test for birth_certificate
#   should validate_presence_of(:birth_certificate)
#   #more

#   #test for medications
#   should allow_value(nil).for(:medications)
#   #more

#   #test for security_question
#   should validate_presence_of(:security_question)
#   #more

#   #test for security_response
#   should validate_presence_of(:security_response)
#   #more

#   # test active
#   should allow_value(true).for(:active)
#   should allow_value(false).for(:active)
#   should_not allow_value(nil).for(:active)

#   context "Creating a student context" do
#     setup do 
#       create_household_context
#       create_guardian_context
#       create_student_context
#       create_tournament_context
#       create_bracket_context
#       create_team_context
#     end
    
#     teardown do
#       remove_team_context
#       remove_bracket_context
#       remove_tournament_context
#       remove_student_context
#       remove_guardian_context
#       remove_household_context
#     end
      
#     # quick test of factories
#     should "have working factories" do
#       assert_equal "Gruberman", @ed.last_name
#       assert_equal "Ted", @ted.first_name
#       assert_equal 9.years.ago.to_date, @noah.dob
#       assert_equal 7, @fred.grade_integer
#       assert_equal false, @jen.gender
#       assert @julie.active
#       deny @jason.active
#     end

#     should "allow an existing student to be edited" do
#       @jason.active = true
#       assert @jason.valid?
      
#       #undo
#       @jason.active = false
#     end
    
#     should "have working name method" do 
#       assert_equal "Gruberman, Ed", @ed.name
#     end
    
#     should "have working proper_name method" do 
#       assert_equal "Ed Gruberman", @ed.proper_name
#     end
    
#     should "have working age method" do 
#       assert_equal 14, @howard.age
#       assert_equal 9, @noah.age
#       assert_equal 18, @julie.age
#     end
    
#     should "strip non-digits from phone" do 
#       assert_equal "4122682323", @ted.cell_phone
#       assert_equal "4125555555", @howard.emergency_contact_phone
#     end
    
#     should "not allow student to be added without a parent" do
#       # a student without a household cannot have a guardian
#       # thus a student without a household should also not be a valid student
#       @brent = FactoryGirl.build(:student)
#       deny @brent.valid?
      
#       @household1 = FactoryGirl.build(:household)
#       @household2 = FactoryGirl.build(:household, street:"5032 Forbes Ave")
#       @henry = FactoryGirl.build(:guardian, household:@household1, first_name:"Henry", last_name:"Michaels", email: "hmichaels@gmail.com")
#       @laura = FactoryGirl.build(:student, gender:false, household:@household2)
#       @tina = FactoryGirl.build(:student, gender:false, household:@household2, first_name: "Tina")

#       # @brent.household = @household2
#       assert_equal true, @laura.valid?
#       # deny @brent.valid?

#     end
    
#     should "have class method for finding students eligible for a particular team" do
#       assert_equal 0, Student.qualifies_for_team(@knicks.id).size
#       assert_equal 4, Student.qualifies_for_team(@heat.id).size
#     end
    
#     should "have class method for finding students between two ages" do 
#       assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Hoover","Marcus"], Student.ages_between(9,15).alphabetical.all.map(&:last_name)
#       assert_equal ["Gruberman","Gruberman","Gruberman","Gruberman","Hanson", "Marcus"], Student.ages_between(11,14).alphabetical.all.map(&:last_name)
#     end
    
#     should "have class method for finding students qualified for a bracket" do 
#       assert_equal ["Gruberman","Gruberman","Gruberman","Marcus"], Student.qualifies_for_bracket(@boys13to15.id).alphabetical.all.map(&:last_name)
#     end
    
#     # start testing scopes...
#     should "have scope for alphabetical listing" do 
#       assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Henderson","Hoover","Marcus"], Student.alphabetical.map(&:last_name)
#     end
    
#     should "have a scope for students without all of their forms" do
#       #create temporary factories
#       @tourn = FactoryGirl.create(:tournament)
#       @bracket = FactoryGirl.create(:bracket, min_age:11, max_age:13, tournament_id:@tourn.id)
#       @celtics = FactoryGirl.create(:team, name:"Boston Celtics", bracket:@bracket)
#       @bad_steve = FactoryGirl.create(:student, first_name:"Steve", dob:12.years.ago)
#       @bad_steve.remove_birth_certificate!
#       @bad_steve.save!
#       @reg_fred = FactoryGirl.create(:registration, student:@fred, team:@celtics)
#       @reg_fred.remove_physical!
#       @reg_fred.save!
#       @reg_ned = FactoryGirl.create(:registration, student:@ned, team:@celtics)
#       @reg_ned.remove_proof_of_insurance!
#       @reg_ned.save!
#       assert_equal ["Fred","Ned","Steve"], Student.alphabetical.without_forms.map(&:first_name)
      
#       @reg_fred.destroy
#       @reg_ned.destroy
#       @bad_steve.destroy
#       @celtics.destroy
#       @bracket.destroy
#       @tourn.destroy
#     end
    
#     should "have scope for active students" do 
#       assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Henderson","Marcus"], Student.active.alphabetical.map(&:last_name)
#     end
    
#     should "have scope for inactive students" do 
#       assert_equal ["Hoover"], Student.inactive.alphabetical.map(&:last_name)
#     end
    
#     should "have scope for male students" do 
#       assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hoover","Marcus"], Student.male.alphabetical.map(&:last_name)
#     end
    
#     should "have scope for female students" do 
#       assert_equal ["Hanson","Henderson"], Student.female.alphabetical.map(&:last_name)
#     end
    
#     should "have scope for students with allergies" do 
#       assert_equal ["Hanson"], Student.has_allergies.alphabetical.map(&:last_name)
#     end
    
#     should "have scope for students who need medications" do 
#       assert_equal ["Henderson","Hoover"], Student.needs_medication.alphabetical.map(&:last_name)
#     end
    
#     should "have scope for ordering by age" do 
#       assert_equal ["Ark","Hoover","Gruberman","Gruberman","Hanson", "Gruberman","Gruberman","Marcus","Henderson"], Student.by_age.alphabetical.map(&:last_name)
#     end

#     ###might be useful for demographics?
#     should "have scope for listing all seniors" do 
#       assert_equal ["Henderson"], Student.seniors.by_age.map(&:last_name)
#     end
    
#     should "have scope for ordering by county" do
#       assert_equal ["Ark", "Gruberman", "Henderson", "Hoover", "Marcus", "Gruberman", "Gruberman", "Hanson", "Gruberman"], Student.by_county.alphabetical.map(&:last_name)
#     end
    
#     should "have scope for ordering by grade" do 
#       assert_equal ["Ark","Hoover", "Gruberman","Gruberman","Gruberman","Gruberman", "Hanson","Marcus","Henderson"], Student.by_grade.alphabetical.map(&:last_name)
#     end

#     should "have a method to display a student's gender as a string" do
#       assert_equal "Male", @noah.sex
#       assert_equal "Female", @jen.sex
#     end

#     should "have a method to display a student's registration for the current year" do
#       assert_equal "Miami Heat", @ed.current_reg.team.name
#       assert_equal nil, @julie.current_reg
#       assert_equal nil, @fred.current_reg
#     end

#     should "have a method to show if a student has submitted their report card" do
#       assert_equal false, @noah.missing_report_card
#       assert_equal true, @ed.missing_report_card
#     end

#     should "deactivate not destroy student and associated registrations" do
#       @ed.destroy
#       @ed.reload
#       deny @ed.active
#       deny @ed_reg1.active
#       deny @ed_reg2.active
#     end

#     should "deactivate student but not err if no registrations" do
#       @julie.destroy
#       @julie.reload
#       deny @julie.active
#     end
#   end
  
# end
