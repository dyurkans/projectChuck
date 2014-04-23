class RegistrationForm < Reform::Form
  include Composition
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::FormBuilderMethods

  model :household
  
  # Household
  properties [:street, :city, :state, :zip, :county, :insurance_provider, :insurance_policy_no,
              :family_physician, :physician_phone], on: :household
  validates :street, :city, :state, :zip, :county, :insurance_provider, :insurance_policy_no, :family_physician, :physician_phone, presence: true 
  
  
  # Student
  properties [:first_name, :last_name, :gender, :dob, :birth_certificate, :cell_phone,
              :emergency_contact_name, :emergency_contact_phone, :school, :school_county,
              :grade_integer, :allergies, :medications, :email, :security_question, :security_response], on: :student

  validates :first_name, :last_name, :gender, :emergency_contact_name, :emergency_contact_phone, :school, :school_county, :grade_integer, on: :student, presence: true
    

  # Registration
  properties [:report_card, :proof_of_insurance, :physical_date, :physical, :t_shirt_size], on: :registration
  
  validates :physical_date, presence: true

  
  # Guardian
  properties [:cell_phone, :day_phone, :dob, :email, :first_name, :gender, :last_name, :receive_texts], on: :guardian
  
  validates :first_name, :last_name, :gender, :receive_texts, on: :guardian, presence: true
  
  
  
  def save
    super
    model.save
  end
end
