require 'test_helper'

class StudentTest < ActiveSupport::TestCase

	#Relationshiop validations
	should belong_to (:household)
	should have_many(:registrations)
	should have_many(:teams).through(:registrations)

	#test first_name
	should validate_presence_of(:first_name)

	#test last_name
	should validate_presence_of(:last_name)

	# test dob
	should_not allow_value(19.years.ago.to_date).for(:dob)
	should allow_value(18.years.ago.to_date).for(:dob)
	should allow_value(14.years.ago.to_date).for(:dob)
	should allow_value(9.years.ago.to_date).for(:dob)
	should allow_value(7.years.ago.to_date).for(:dob)
	should_not allow_value(5.years.ago).for(:dob)
	should_not allow_value("bad").for(:dob)
	should_not allow_value(nil).for(:dob)

	# tests for cell_phone
	should allow_value("4122683259").for(:cell_phone)
	should allow_value("412-268-3259").for(:cell_phone)
	should allow_value("412.268.3259").for(:cell_phone)
	should allow_value("(412) 268-3259").for(:cell_phone)
	should allow_value(nil).for(:cell_phone)
	should_not allow_value("2683259").for(:cell_phone)
	should_not allow_value("14122683259").for(:cell_phone)
	should_not allow_value("4122683259x224").for(:cell_phone)
	should_not allow_value("800-EAT-FOOD").for(:cell_phone)
	should_not allow_value("412/268/3259").for(:cell_phone)
	should_not allow_value("412-2683-259").for(:cell_phone)

	#test emergency_contact_name
	should validate_presence_of(:emergency_contact_name)

	# tests for emergency_contact_phone
	should allow_value("4122683259").for(:emergency_contact_phone)
	should allow_value("412-268-3259").for(:emergency_contact_phone)
	should allow_value("412.268.3259").for(:emergency_contact_phone)
	should allow_value("(412) 268-3259").for(:emergency_contact_phone)
	should allow_value(nil).for(:emergency_contact_phone)
	should_not allow_value("2683259").for(:emergency_contact_phone)
	should_not allow_value("14122683259").for(:emergency_contact_phone)
	should_not allow_value("4122683259x224").for(:emergency_contact_phone)
	should_not allow_value("800-EAT-FOOD").for(:emergency_contact_phone)
	should_not allow_value("412/268/3259").for(:emergency_contact_phone)
	should_not allow_value("412-2683-259").for(:emergency_contact_phone)

	#test grade

	####This should probably be stored as an int and changed appropriately

	should allow_value("3").for(:grade_integer)
	should allow_value("12").for(:grade_integer)
	should allow_value("Sixth").for(:grade_integer)
	should_not allow_value(0).for(:grade_integer)
	should_not allow_value(nil).for(:grade_integer)

	#test gender
	should allow_value(true).for(:gender)
	should allow_value(false).for(:gender)
	should_not allow_value(nil).for(:gender)

	#test household_id
	should validate_numericality_of(:household_id)
	should_not allow_value(3.14159).for(:household_id)
	should_not allow_value(0).for(:household_id)
	should_not allow_value(-1).for(:household_id)

	#test for school
	should validate_presence_of(:school)

	#test for school_county
	should validate_presence_of(:school_county)

	#test for allergies

	#test for birth_certificate
	should validate_presence_of(:birth_certificate)
	#more

	#test for medications
	should allow_value(nil).for(:medications)
	#more

	#test for security_question
	should validate_presence_of(:security_question)
	#more

	#test for security_response
	should validate_presence_of(:security_response)
	#more

	# test active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

    context "Creating a student context" do
    setup do 
      create_student_context
    end
    
    teardown do
      remove_student_context
    end
      
    # quick test of factories
    should "have working factories" do
      assert_equal "Gruberman", @ed.last_name
      assert_equal "Ted", @ted.first_name
      assert_equal 9.years.ago.to_date, @noah.dob
      assert_equal 7, @fred.grade_integer
      assert_equal false, @jen.gender
      assert @julie.active
      deny @jason.active
    end

    should "allow an existing student to be edited" do
      @jason.active = true
      assert @jason.valid?
      
      #undo
      @jason.active = false
    end
    
    should "have working name method" do 
      assert_equal "Gruberman, Ed", @ed.name
    end
    
    should "have working proper_name method" do 
      assert_equal "Ed Gruberman", @ed.proper_name
    end
    
    should "have working age method" do 
      assert_equal 14, @howard.age
      assert_equal 13, @noah.age
      assert_equal 16, @julie.age
    end
    
    should "strip non-digits from phone" do 
      assert_equal "4122682323", @ted.cell_phone
      assert_equal "4125555555", @howard.emergency_contact_phone
    end
    
    should "not allow student to be added without a parent" do
      # a student without a household cannot have a guardian
      # thus a student without a household should also not be a valid student
      @brent = FactoryGirl.create(:student, household_id:nil)
      deny @brent.valid?
      
      @household1 = FactoryGirl.create(:household)
      @household2 = FactoryGirl.create(:household, street:"5032 Forbes Ave")
      @henry = FactoryGirl.create(:guardian, household_id:@household1.id, first_name:"Henry", last_name:"Michaels")
      @laura = FactoryGirl.create(:student, gender:false, household_id:@household1.id)

      @brent.household_id = @household2.id
      assert_equal true, @laura.valid?
      deny @brent.valid?
    end
    
    should "have class method for finding a students guardians" do
      #setup temporary factories
      @household1 = FactoryGirl.create(:household)
      @household2 = FactoryGirl.create(:household, street:"5032 Forbes Ave")
      @mary = FactoryGirl.create(:guardian, household_id:@household1.id)
      @grant = FactoryGirl.create(:guardian, household_id:@household1.id, first_name:"Grant", last_name:"Hillworth", gender:true, cell_phone:nil)
      @stephen = FactoryGirl.create(:guardian, household_id:@household2.id, first_name:"Stephen", last_name:"Francois", gender:true)
      @fred.household_id = @household1.id
      @howard.household_id = @household2.id
      
      assert_equal ["Gruberman","Hillworth"], Student.guardians(@fred.id).alphabetical.all.map(&:last_name)
      assert_equal ["Francois"], Student.guardians(@fred.id).alphabetical.all.map(&:last_name)
      
      #remove temporary factories
      @household1.destroy
      @household2.destroy
      @mary.destroy
      @grant.destroy
      @stephen.destroy
      @fred.household_id = nil
      @howard.household_id = nil
    end
    
    should "have class method for finding students eligible for a particular team" do
      @bracket = FactoryGirl.create(:bracket, min_age:9, max_age:12);
      @knicks = FactoryGirl.create(:team, bracket_id:@bracket.id);
      assert_equal ["Ark","Gruberman","Hoover"], Student.qualies_for_team(@knicks.id).alphabetical.all.map(&:last_name)
      
      # remove extra context
      @bracket.destroy
      @knicks.destroy
    end
    
    should "have class method for finding students between two ages" do 
      assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Hoover","Marcus"], Student.ages_between(9,15).alphabetical.all.map(&:last_name)
      assert_equal ["Gruberman","Gruberman","Gruberman","Gruberman","Marcus"], Student.ages_between(11,14).alphabetical.all.map(&:last_name)
    end
    
    should "have class method for finding students qualified for a bracket" do 
      #create temporary bracket
      @bracket = FactoryGirl.create(:bracket, min_age:14, max_age:17)
      assert_equal ["Gruberman","Gruberman","Henderson","Marcus"], Student.qualies_for_bracket(@bracket.id).alphabetical.all.map(&:last_name)
      
      #remove temporary bracket
      @bracket.destroy
    end
    
    # start testing scopes...
    should "have scope for alphabetical listing" do 
      assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Henderson","Hoover","Marcus"], Student.alphabetical.all.map(&:last_name)
    end
    
    should "have a scope for students without all of their forms" do
      #create temporary factories
      @bracket = FactoryGirl.create(:bracket, min_age:11, max_age:13)
      @celtics = FactoryGirl.create(:team, name:"Boston Celtics", bracket_id:@bracket.id)
      @reg_fred = FactoryGirl.create(:registration, student_id:@fred.id, team_id:@celtics.id,
                                     proof_of_insurance:"documents/prof_of_insurance/FGruberman.pdf",
                                     report_card:"documents/report_card/Fred",physical:"documents/physical/FredGruberman")
      @reg_ned = FactoryGirl.create(:registration, student_id:@ned.id, team_id:@celtics.id,
				      proof_of_insurance:"documents/prof_of_insurance/NGruberman.png",
                                     report_card:"documents/report_card/Ned.pdf",physical:"documents/physical/NedGruberman.jpg")
      assert_equal ["Fred","Ned"], Student.without_forms.alphabetical.all.map(&:first_name)
      
      #remove temporary factories
      @bracket.destroy
      @celtics.destroy
      @reg_fred.destroy
      @reg_ned.destroy
    end
    
    should "have scope for active students" do 
      assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Henderson","Marcus"], Student.active.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for inactive students" do 
      assert_equal ["Hoover"], Student.inactive.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for male students" do 
      assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hoover","Marcus"], Student.male.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for students" do 
      assert_equal ["Hanson","Henderson"], Student.female.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for students with allergies" do 
      assert_equal ["Hanson"], Student.has_allergies.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for students who need medications" do 
      assert_equal ["Henderson","Hoover"], Student.needs_medication.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for ordering by age" do 
      assert_equal ["Ark","Hoover","Gruberman","Gruberman","Gruberman","Gruberman","Hoover","Marcus","Henderson"], Student.by_age.all.map(&:last_name)
    end

    ###might be useful for demographics?
    should "have scope for listing all seniors" do 
      assert_equal ["Henderson"], Student.seniors.by_age.all.map(&:last_name)
    end
    
    should "have scope for ordering by county" do
      assert_equal ["Ark","Gruberman","Hoover","Gruberman","Hanson","Gruberman","Gruberman"], Student.by_county.all.map(&:last_name)
    end
    
    should "have scope for ordering by grade" do 
      assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Henderson","Hoover","Marcus"], Student.by_grade.all.map(&:last_name)
    end
  end
	
end
