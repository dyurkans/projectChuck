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

  # tests for email
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

  #test household_id
  should validate_numericality_of(:household_id)
  should allow_value(3).for(:household_id)
  should allow_value(nil).for(:household_id)
  should_not allow_value(3.14159).for(:household_id)
  should_not allow_value(0).for(:household_id)
  should_not allow_value(-1).for(:household_id)
  
  # test receive_texts
  should allow_value(true).for(:receive_texts)
  should allow_value(false).for(:receive_texts)
  should_not allow_value(nil).for(:receive_texts)
  
  #test gender
  should allow_value(true).for(:gender)
  should allow_value(false).for(:gender)
  should_not allow_value(nil).for(:gender)
  
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

    should "have working factories" do
      #Households
      @grub.valid?
      @mill.valid?
      @suth.valid?
      @bam.valid?
      #Guardians
      @mary.valid?
      @eric.valid?
      @alex.valid?
      @leo.valid?
      @james.valid?
    end
      
    should "allow an existing guardian to be edited" do
      @james.active = true
      assert @james.valid?
      @james.active = false
    end
      
    should "have working name method" do 
      assert_equal "Gruberman, Eric", @eric.name
    end
      
    should "have working proper_name method" do 
      assert_equal "Eric Gruberman", @eric.proper_name
    end

    should "have scope for alphabetical listing" do 
      assert_equal [@james, @eric, @mary, @alex, @leo], Guardian.alphabetical
    end

    should "have scope for active guardians" do 
      assert_equal [@eric, @mary, @alex, @leo], Guardian.active.alphabetical
    end
      
    should "have scope for inactive guardians" do 
      assert_equal [@james], Guardian.inactive.alphabetical
    end

    should "have a method to display a guardian's gender as a string" do
      assert_equal "Male", @eric.sex
      assert_equal "Female", @mary.sex
    end

    should "not allow two guardians to have the same email" do
      @bob = FactoryGirl.build(:guardian, first_name: "Bob")
      deny @bob.valid?
      @bob = FactoryGirl.create(:guardian, first_name: "Bob", email: "bob@example.com")
      @bob.valid?
      @bob.destroy
    end

    should "have a scope for all guardians signed up for text notifications" do
      assert_equal [@james, @mary, @alex], Guardian.receive_text_notifications.alphabetical
    end

    should "strip non-digits from phone" do 
      assert_equal "4122818080", @alex.day_phone
      assert_equal "4126667890", @eric.cell_phone
    end
  
    should "titleize first and last names" do
      @bob = FactoryGirl.create(:guardian, first_name: "  bob", last_name: "EXAmPLe   ", email: "bob@example.com")
      assert_equal "Bob", @bob.first_name
      assert_equal "Example", @bob.last_name
      @bob.destroy
    end

  end
  
end
