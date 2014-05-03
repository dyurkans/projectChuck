class RegistrationForm < Reform::Form
  include Composition
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods
  include Reform::Form::ActiveRecord
  
  # Household
  properties [:street, :city, :state, :zip, :county, :insurance_provider, :insurance_policy_no,
              :family_physician, :physician_phone], on: :household

  # Guardian
  properties [:household_id, :cell_phone, :day_phone, :dob, :email, :first_name, :gender, :last_name, :receive_texts], on: :guardian

  # Student
  properties [:household_id, :first_name, :last_name, :gender, :dob, :birth_certificate, :cell_phone,
              :emergency_contact_name, :emergency_contact_phone, :school, :school_county,
              :grade_integer, :allergies, :medications, :email, :security_question, :security_response], on: :student

  # Registration
  properties [:student_id, :report_card, :proof_of_insurance, :physical_date, :physical, :t_shirt_size], on: :registration  

#   model :household
  
  validates :street, :city, :state, :zip, :county, :insurance_provider, :insurance_policy_no, :family_physician, :physician_phone, on: :household, presence: true
  validates :first_name, :last_name, :gender, :receive_texts, on: :guardian, presence: true
  validates :first_name, :last_name, :gender, :emergency_contact_name, :emergency_contact_phone, :school, :school_county, :grade_integer, on: :student, presence: true
  validates :physical_date, on: :registration, presence: true

  def persisted?
    false
  end
  
  class RegistrationFailed < Exception
  end
  
  
  def persist!(params)
    if validate(params)
      begin
        save do |data, nested|
          puts "Nested is: #{nested}"
          puts "Data is: #{data}"
          puts "Guardian is: #{data.guardian.day_phone}"
          Household.create!(nested[:household])
          Guardian.create!(nested[:guardian])
          Student.create!(nested[:student])
          Registration.create!(nested[:registration])
        end
      rescue RegistrationForm::RegistrationFailed
        false
      end
    end
  end
  
  def to_key
    [1]
  end
  
#   def save
#     super
#     model.save
#   end
end
