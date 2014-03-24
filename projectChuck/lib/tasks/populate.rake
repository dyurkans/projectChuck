namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'

    # Create 100 households
    100.times do |i|
      h = Household.new
      h.street = Faker::Address.street_address
      h.city = Faker::Address.city
      h.state = "PA"
      h.zip = %w[15120 15213 15212 15090 15237 15207 15217 15227 15203 15210].sample
      h.home_phone = rand(10 ** 10).to_s.rjust(10,'0')
      h.insurance_provider = ["UPMC", "Highmark", "HealthAmerica"].sample
      h.insurance_policy_no = rand(10 ** 10).to_s.rjust(10,'0')
      h.family_physician = "Dr. #{Faker::Name.first_name} #{Faker::Name.last_name}"
      h.physician_phone = rand(10 ** 10).to_s.rjust(10,'0')
      h.active = true
      h.save!
      household_last_name = Faker::Name.last_name
      puts "Add #{household_last_name} household"


      # Create 1..4 kids per household
      num_kids = [1,2,3,4].sample
      puts "#{num_kids} children in this household"
      num_kids.times do |j|
        s = Student.new
        s.household_id = h.id
        s.first_name = Faker::Name.first_name
        if rand(5).zero?
          s.last_name = Faker::Name.last_name
        else
          s.last_name = household_last_name
        end
        months_old = (100..180).to_a.sample
        s.dob = months_old.months.ago.to_date
        s.cell_phone = rand(10 ** 10).to_s.rjust(10,'0')
        s.school = "#{h.city} School"
        if rand(4).zero?
          s.school_county = "Howard"
        else
          s.school_county = "Allegheny"
        end
        s.gender = rand(2).zero? # i.e., can only 0 or 1 so 50-50 chance boy or girl
        s.grade_integer = (months_old/12) - 5
        s.emergency_contact_name = Faker::Name.name
        s.emergency_contact_phone = rand(10 ** 10).to_s.rjust(10,'0')
        s.birth_certificate = "#{s.last_name}#{s.first_name}.pdf"
        if rand(4).zero?
          s.allergies = "#{rand(2).zero? ? 'Peanuts' : 'Bee stings'}"
        else
          s.allergies = ""
        end
        if rand(4).zero?
          s.medications = "Inhaler"
        else
          s.medications = ""
        end
        s.security_question = 0
        s.security_response = "42"
        s.active = true  
        s.save!      
        puts "Adding student #{s.proper_name} to household"
      end

      # add one or two guardians per household
      num_guardians = [1,2].sample
      puts "#{num_guardians} in this household"
      num_guardians.times do
        g = Guardian.new
        g.household_id = h.id
        g.first_name = Faker::Name.first_name
        if rand(5).zero?
          g.last_name = Faker::Name.last_name
        else
          g.last_name = household_last_name
        end
        age = (30..55).to_a.sample
        g.dob = age.years.ago.to_date
        g.cell_phone = rand(10 ** 10).to_s.rjust(10,'0')
        g.day_phone = rand(10 ** 10).to_s.rjust(10,'0')
        g.receive_texts = !rand(4).zero?
        g.email = "#{g.first_name.downcase}.#{g.last_name.downcase}@example.com"
        g.gender = rand(2).zero? # 50-50 change M/F; could have FF or MM households
        g.active = true
        if g.save!
          puts "Adding guardian #{g.proper_name} to household"
        end
      end
    end
  end
end