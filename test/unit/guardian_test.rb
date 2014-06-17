require 'test_helper'

class GuardianTest < ActiveSupport::TestCase

  #Relationshiop validations
  should have_one(:user)
  should belong_to(:household)
  #next iteration //should have_many(:volunteers)

  #test first_name
  should validate_presence_of(:first_name)

  #test last_name
  should validate_presence_of(:last_name)

  # tests for day_phone
  should allow_value("4122683259").for(:day_phone)
  should allow_value("412-268-3259").for(:day_phone)
  should allow_value("412.268.3259").for(:day_phone)
  should allow_value("(412) 268-3259").for(:day_phone)
  should allow_value(nil).for(:day_phone)
  should_not allow_value("2683259").for(:day_phone)
  should_not allow_value("14122683259").for(:day_phone)
  should_not allow_value("4122683259x224").for(:day_phone)
  should_not allow_value("800-EAT-FOOD").for(:day_phone)
  should_not allow_value("412/268/3259").for(:day_phone)
  should_not allow_value("412-2683-259").for(:day_phone)    

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

  # test receive_texts
  should allow_value(true).for(:receive_texts)
  should allow_value(false).for(:receive_texts)
  should_not allow_value(nil).for(:receive_texts)

  # tests for email
  should validate_uniqueness_of(:email).case_insensitive
  #I added this in case there's the adult has no email
  should allow_value(nil).for(:email)
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)

  #test gender
  should allow_value(true).for(:gender)
  should allow_value(false).for(:gender)
  should_not allow_value(nil).for(:gender)

  #test household_id
  should validate_numericality_of(:household_id)
  should_not allow_value(3.14159).for(:household_id)
  should_not allow_value(0).for(:household_id)
  should_not allow_value(-1).for(:household_id)

  # test active
  should allow_value(true).for(:active)
  should allow_value(false).for(:active)
  should_not allow_value(nil).for(:active)

  context "Creating a guardian context" do
    setup do
    create_household_context
    create_guardian_context
    end
      
    teardown do
    remove_guardian_context
    remove_household_context
    end
      
    #test that factories work
      should "have working factories" do
        assert_equal "Mary", @mary.first_name
        assert_equal "Gruberman", @eric.last_name
        assert_equal false, @leo.receive_texts
        assert_equal "james@hotmail.com", @james.email
        assert_equal false, @james.active
    end
      
    should "allow an existing guardian to be edited" do
    @james.active = true
    assert @james.valid?
        
    #undo
    @james.active = false
    end
      
    should "have working name method" do 
      assert_equal "Gruberman, Eric", @eric.name
    end
      
    should "have working proper_name method" do 
      assert_equal "Eric Gruberman", @eric.proper_name
    end
      
    should "strip non-digits from phone" do 
      assert_equal "4122818080", @alex.day_phone
      assert_equal "4126667890", @eric.cell_phone
    end

    #test scopes
    should "have scope for alphabetical listing" do 
      assert_equal ["Bambridge","Gruberman","Gruberman","Mill","Sutherland"], Guardian.alphabetical.all.map(&:last_name)
    end
      
    should "have scope for active guardians" do 
      assert_equal ["Gruberman","Gruberman","Mill","Sutherland"], Guardian.active.alphabetical.all.map(&:last_name)
    end
      
    should "have scope for inactive guardians" do 
      assert_equal ["Bambridge"], Guardian.inactive.alphabetical.all.map(&:last_name)
    end

    should "have a method to display a guardian's gender as a string" do
      assert_equal "Male", @eric.sex
      assert_equal "Female", @mary.sex
    end

    should "not allow two guardians to have the same email" do
      @bob = FactoryGirl.build(:guardian, first_name: "Bob")
      deny @bob.valid?
    end

    should "deactivate, not delete a guardian" do
      @mary.destroy
      @mary.reload
      deny @mary.active
    end
  end
  
end
