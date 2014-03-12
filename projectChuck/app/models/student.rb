class Student < ActiveRecord::Base
  attr_accessible :active, :allergies, :birth_certificate, :cell_phone, :dob, :emergency_contact_name, :emergency_contact_phone, :first_name, :gender, :grade_integer, :household_id, :last_name, :medications, :school, :school_county, :security_question, :security_response
end
