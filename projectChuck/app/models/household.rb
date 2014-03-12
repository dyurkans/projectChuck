class Household < ActiveRecord::Base
  attr_accessible :active, :city, :family_physician, :home_phone, :insurance_policy_no, :insurance_provider, :physician_phone, :state, :street, :zip
end
