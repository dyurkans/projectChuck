require 'test_helper'

class UserTest < ActiveSupport::TestCase

	#Relationshiop validations
	should belong_to(:guardian)

	# test active
	should allow_value(true).for(:active)
	should allow_value(false).for(:active)
	should_not allow_value(nil).for(:active)

	#test guardian id
	should validate_numericality_of(:guardian_id)
	should allow_value(3).for(:guardian_id)
	should allow_value(nil).for(:guardian_id)
	should_not allow_value(3.14159).for(:guardian_id)
	should_not allow_value(0).for(:guardian_id)
	should_not allow_value(-1).for(:guardian_id)

	# tests for email
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
	should_not allow_value(nil).for(:email)

	#tests for role
	should allow_value("Admin").for(:role)
	#Currently only implementing one role. 
	#Expand to volunteer, guest, etc. in further iterations.
	should allow_value("Member").for(:role)
	should_not allow_value("bad").for(:role)
	should_not allow_value("hacker").for(:role)
	should_not allow_value(10).for(:role)
	should_not allow_value("leader").for(:role)
	should_not allow_value(nil).for(:role)
  

  def new_user(attributes = {})
  	@ed = FactoryGirl.create(:student)
    attributes[:email] ||= 'foo@example.com'
    attributes[:guardian_id] ||= @ed.id
    attributes[:password_confirmation] ||= 'abc123'
    user = User.new(attributes)
    user.valid? # run validations
    user
  end

  def setup
    User.delete_all
  end

  def test_valid
    assert new_user.valid?
  end

  def test_require_password
    assert_equal ["can't be blank"], new_user(:password_confirmation => '').errors[:password_confirmation]
  end

  def test_require_well_formed_email
    assert_equal ["is invalid"], new_user(:email => 'foo@bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_email
    new_user(:email => 'bar@example.com').save!
    assert_equal ["has already been taken"], new_user(:email => 'bar@example.com').errors[:email]
  end

  def test_validate_password_length
    assert_equal ["is too short (minimum is 4 characters)"], new_user(:password_confirmation => 'bad').errors[:password_confirmation]
  end

  def test_generate_password_hash_and_salt_on_create
  	User.delete_all
    user = new_user
    user.save!
    assert user.password_hash
    assert user.password_salt
  end

  def test_authenticate_by_email
    User.delete_all
    user = new_user(:email => 'foo2@bar.com', :password_confirmation => 'secret')
    user.save!
    assert_equal user, User.authenticate('foo2@bar.com', 'secret')
  end

  def test_authenticate_bad_email
    assert_nil User.authenticate('nonexisting', 'secret')
  end

  def test_authenticate_bad_password
    User.delete_all
    new_user(:email => 'foo1@bar.com', :password_confirmation => 'secret').save!
    assert_nil User.authenticate('foo1@bar.com', 'badpassword')
  end

end
