include ActionDispatch::TestProcess
FactoryGirl.define do
	
	factory :student do
		first_name "Ed"
		last_name "Gruberman"
		dob Date.new(14.years.ago.year, 8, 1)
		cell_phone { rand(10 ** 10).to_s.rjust(10,'0') }
		school "Brentwood High School"
		school_county "Allegheny"
		grade_integer 10
		gender true
		email "mg@example.com"
		emergency_contact_name "Mary Gruberman"
		emergency_contact_phone { rand(10 ** 10).to_s.rjust(10,'0') }
		birth_certificate { fixture_file_upload(Rails.root.join('public', 'example_files', 'birth_certificate.pdf'), "application/pdf") }
		allergies nil
		medications nil
		security_question 0
		security_response "Fido"
		active true
	end

	factory :registration do
		report_card { fixture_file_upload(Rails.root.join('public', 'example_files', 'report_card.jpg'), "application/jpg") }
		proof_of_insurance { fixture_file_upload(Rails.root.join('public', 'example_files', 'insurance.png'), "application/png") }
		physical { fixture_file_upload(Rails.root.join('public', 'example_files', 'physical.pdf'), "application/pdf") }
		physical_date 3.months.ago.to_date
		t_shirt_size 2
		active true
		volunteer_initials "DY"
	end

	factory :team do 
		name "New York Knicks"
		max_students 10
		notes "This is where notes about a team should go."
		coach "Coach Dima"
		coach_email "coach@example.com"
		coach_cell { rand(10 ** 10).to_s.rjust(10,'0') }
		assistant_coach "Assistant Name"
		assistant_coach_cell { rand(10 ** 10).to_s.rjust(10,'0') }
		assistant_coach_email "assistant@example.com"
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
		county "Allegheny"
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
		cell_phone { rand(10 ** 10).to_s.rjust(10,'0') } 
		day_phone { rand(10 ** 10).to_s.rjust(10,'0') }
		receive_texts true
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

	factory :tournament do
		start_date 2.weeks.from_now
		end_date 12.weeks.from_now
	end
	
end
