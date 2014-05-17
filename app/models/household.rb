class Household < ActiveRecord::Base  
   	# Relationships
	has_many :students
	has_many :guardians

accepts_nested_attributes_for :guardians, :students
attr_accessible :medical_agreement, :permission_agreement, :student_agreement, :parent_agreement, :overall_agreement, :guardians_attributes, :students_attributes, :county, :active, :city, :family_physician, :home_phone, :insurance_policy_no,:insurance_provider, :physician_phone, :state, :street, :zip

	# Callbacks
	before_save :reformat_phone
	before_save :reformat_physician_phone
  before_save :reformat_text

	# Scopes
	scope :active, where('households.active = ?', true)
	scope :inactive, where('households.active = ?', false)
	scope :by_last_name, joins(:guardians).order('guardians.last_name').group('households.id','guardians.last_name','guardians.household_id')


	# Lists
	STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]


	# Validations
  validates_acceptance_of :medical_agreement, :permission_agreement, :student_agreement, :parent_agreement, :overall_agreement, :on => :create, :message => "Must be accepted"
	validates_presence_of :street, :city, :message => "Can't be blank"
	validates_inclusion_of :state, :in => STATES_LIST.map {|k, v| v}, :message => "Not a recognized State"
	validates_format_of :zip, :with => /^\d{5}$/, :message => "Should be five digits long"
	validates_inclusion_of :active, :in => [true, false]
  validates_format_of :home_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "Should be 10 digits (area code needed) and separated with dashes only", :allow_blank => true
  validates_format_of :physician_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "Should be 10 digits (area code needed) and separated with dashes only", :allow_blank => true
  validates_inclusion_of :active, :in => [true, false]
  validates_format_of :family_physician, :with => /((Dr\.|Dr|Doctor)\s)?([^\d\s]+\s?){2,}(\, M\.D\.)?/i, :allow_blank => true


	# Other methods
	def full_address
	"#{street}, #{city}, #{state} #{zip}"
	end

	def name
		guardians = self.guardians.alphabetical
		name = ""
		index = 0
    if guardians.size > 0
      for g in guardians
        if index != guardians.size - 1
          name += g.first_name + " " + g.last_name + "/"
        else 
          name += g.first_name + " " + g.last_name
        end
        index += 1
      end
    else
      name = full_address
    end
		name
	end

	  # Private methods
  private
  def reformat_phone
    phone = self.home_phone.to_s  # change to string in case input as all numbers 
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.home_phone = phone       # reset self.phone to new string
  end

  def reformat_physician_phone
    phone = self.physician_phone.to_s  # change to string in case input as all numbers 
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.physician_phone = phone       # reset self.phone to new string
  end

  def reformat_text
    self.city = self.city.downcase.squish.titleize
    self.county = self.county.downcase.squish.titleize
    self.family_physician = self.family_physician.downcase.squish.titleize
    self.insurance_provider = self.insurance_provider.downcase.squish.titleize
  end

end
