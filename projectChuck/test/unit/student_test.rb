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

    should "allow an existing student to be edited" do
      @jason.active = true
      assert @jason.valid?
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
      assert_equal "4122682323", @ted.phone
      assert_equal "4125555555", @howard.emergency_contact_phone
    end
	
    should "have class method for finding students on a particular team" do
      @bracket = FactoryGirl.create(:bracket, min_age:9, max_age:12);
      @knicks = FactoryGirl.create(:team, bracket_id:@bracket.id);
      
      ##these lines can be uncommented once 'team_id' is relocated from registration, to student
      #@reg_fred = FactoryGirl.create(:registration, :student => @fred, :team => @knicks)
      #@reg_jason = FactoryGirl.create(:registration, :student => @jason, :team => @knicks)
      ## run the test
      #students = Student.registered_for_team(@knicks.id)
      #assert_equal ["Fred","Jason"], students.map{|s| s.first_name}.sort!
      
      # remove extra context
      @bracket.destroy
      @knicks.destroy
      
      ##these lines can be uncommented once 'team_id' is relocated from registration, to student
      #@reg_fred.destroy
      #@reg_jason.destroy
    end
    
    should "have class method for finding students between two ages" do 
      assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Marcus"], Student.ages_between(9,15).alphabetical.all.map(&:last_name)
      assert_equal ["Gruberman","Gruberman","Gruberman","Gruberman","Marcus"], Student.ages_between(11,14).alphabetical.all.map(&:last_name)
    end
    
    should "have class method for finding students qualified for a bracket" do 
      #create temporary bracket
      @bracket = FactoryGirl.create(:bracket, min_age:14, max_age:17);
      assert_equal ["Gruberman","Gruberman","Henderson","Marcus"], Student.qualies_for_bracket(@bracket.id).alphabetical.all.map(&:last_name)
    end
    
     ###should we have this?
     #should "not allow ages_between class method to have a nil value for max_age" do 
     #  assert_equal nil, Student.ranks_between(12,nil).alphabetical.all.map(&:last_name)
     #end
    
    # start testing scopes...
    ###scopes and custom methods should not return inactive students
    should "have scope for alphabetical listing" do 
      assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Henderson","Marcus"], Student.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for active students" do 
      assert_equal ["Ark","Gruberman","Gruberman","Gruberman","Gruberman","Hanson","Henderson","Marcus"], Student.active.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for inactive students" do 
      assert_equal ["Hoover"], Student.inactive.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for students with allergies" do 
      assert_equal ["Hanson"], Student.has_allergies.alphabetical.all.map(&:last_name)
    end
    
    should "have scope for students who need medications" do 
      assert_equal ["Henderson"], Student.needs_medication.alphabetical.all.map(&:last_name)
    end
    
    ###should this scope include inactive students?
    should "have scope for ordering by age" do 
      assert_equal ["Ark","Hoover","Gruberman","Gruberman","Gruberman","Gruberman","Marcus","Henderson"], Student.by_age.all.map(&:last_name)
    end

    ###might be useful for demographics?
    should "have scope for listing all seniors" do 
      assert_equal ["Henderson"], Student.seniors.by_age.all.map(&:last_name)
    end
    
    # should "deactivate not destroy student and associated user" do
    #   @noah_user = FactoryGirl.create(:user, student: @noah, email: "noah@example.com")
    #   @noah.destroy
    #   # test that Noah is now inactive
    #   # reload Noah again in the database to make sure changes saved
    #   @noah.reload
    #   deny @noah.active
    #   # test that the noah_user is also inactive
    #   deny @noah.user.active
    #   @noah_user.delete
    # end
    # 
    # should "deactivate student but not err if no user account" do
    #   @ted.destroy
    #   # test that Ted is now inactive
    #   # find Ted again in the database to make sure changes saved
    #   @ted.reload
    #   deny @ted.active
    # end
    # 
    # should "deactivate student should remove any upcoming registrations" do
    #   # additional context for this test
    #   sparring = FactoryGirl.create(:event)
    #   breaking = FactoryGirl.create(:event, name: "Breaking")
    #   fall = FactoryGirl.create(:tournament)
    #   wy_belt_sparring = FactoryGirl.create(:section, event: sparring, tournament: fall)
    #   wy_belt_breaking = FactoryGirl.create(:section, event: breaking, tournament: fall)
    #   reg_ted_sp = FactoryGirl.create(:registration, student: @ted, section: wy_belt_sparring)
    #   reg_ted_br = FactoryGirl.create(:registration, student: @ted, section: wy_belt_breaking)
    #   
    #   @ted.destroy
    #   # reload Ted from the database to make sure changes saved
    #   @ted.reload
    #   # test that both of Ted's registrations are removed
    #   assert_equal 0, @ted.registrations.size
    #   
    #   # remove additional context
    #   sparring.delete
    #   breaking.delete
    #   fall.delete
    #   wy_belt_sparring.delete
    #   wy_belt_breaking.delete
    #   reg_ted_sp.delete
    #   reg_ted_br.delete
    # end
    # 
    # should "deactivate student should end any current dojo assignment" do
    #   cmu = FactoryGirl.create(:dojo)
    #   ted_assignment = FactoryGirl.create(:dojo_student, student: @ted, dojo: cmu, end_date: nil)
    #   @ted.destroy
    #   @ted.reload
    #   assert_equal Date.today, @ted.dojo_students.last.end_date
    # end
	
end
