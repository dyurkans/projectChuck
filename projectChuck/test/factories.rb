FactoryGirl.define do
	
	factory :student do
		first_name "Ed"
		last_name "Gruberman"
		dob 16.years.ago.to_date
		cell_phone { rand(10 ** 10).to_s.rjust(10,'0') }
		school "Brentwood High School"
		school_county "Allegheny"
		grade_integer "Tenth"
		gender true
		emergency_contact_name "Mary Gruberman"
		emergency_contact_phone { rand(10 ** 10).to_s.rjust(10,'0') }
		birth_certificate "documents/birth_certificates/EGruberman.pdf"
		allergies "none"
		medications	"none"
		security_question 0
		security_response "Fido"
		active true
	end

	factory :registration do
		report_card "documents/report_card/EGruberman"
		proof_of_insurance "documents/proof_of_insurance/EGruberman.pdf"
		physical "documents/physical/EGruberman.pdf"
		physical_date 3.months.ago.to_date
		date Date.today
		t_shirt_size 2
		active true
	end

	factory :team do 
		name "New York Knicks"
		max_students 10
	end

	factory :bracket do
		gender true
		min_age 16
		max_age 18
	end

	factory :household do
		street "5000 Forbes Avenue"
		city "Pittsburgh"
		state "PA"
		zip "15213"
		home_phone { rand(10 ** 10).to_s.rjust(10,'0') }
		insurance_provider "AIG"
		insurance_policy_no "1938475069"
		family_physician "Dr. John Doe"
		physician_phone { rand(10 ** 10).to_s.rjust(10,'0') }
		active true
	end

	factory :guardian do
		first_name "Mary"
		last_name "Gruberman"
		dob 40.years.ago.to_date
		cell_phone { rand(10 ** 10).to_s.rjust(10,'0') } 
		day_phone { rand(10 ** 10).to_s.rjust(10,'0') }
		receive_text_messages true
		email "marygruberman@example.com"
		gender false
		active true
	end

	factory :user do
		password_digest "secret"
		email "gruberman@example.com"
		role "admin"
		active true
	end
	
end
