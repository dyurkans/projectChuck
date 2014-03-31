class Household < ActiveRecord::Base
  attr_accessible :active, :city, :family_physician, :home_phone, :insurance_policy_no,:insurance_provider, :physician_phone, :state, :street, :zip
  
   	# Relationships
	has_many :students
	has_many :guardians

	# Scopes
	scope :active, where('active = ?', true)
	scope :inactive, where('active = ?', false)
	scope :by_last_name, joins(:guardian).order('guardian.last_name') #can i do this join?


	# Lists
	STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]


	# Validations
	validates_presence_of :street, :city, :family_physician, :insurance_provider, :insurance_policy_no
	validates_inclusion_of :state, :in => STATES_LIST.map {|k, v| v}, :message => "is not a recognized state in the system"
	validates_format_of :zip, :with => /^\d{5}$/, :message => "should be five digits long"
	validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  	validates_format_of :home_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  	validates_format_of :physician_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits (area code needed) and separated with dashes only"
  	#regex for policy number?
  	validates_inclusion_of :active, :in => [true, false], :message => "must be true or false"
  	validates_format_of :family_physician, :with => /(Dr\.|Dr|Doctor)?[\w]{2,}/


	# Other methods
	def full_address
	"#{street}, #{city}, #{state} #{zip}"
	end



end

#Other Notes
#Should insurance information actually be required? What if a family doesn't have insurance?""