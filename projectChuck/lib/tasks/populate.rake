namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
#     [Tournament, Registration, Student, Guardian, Household, User, Bracket, Team].each(&:delete_all)

    #Create a tournament
    tourn = Tournament.new
    tourn.start_date = Date.today
    tourn.end_date = tourn.start_date + 3.months
    tourn.save!
    
    
    # Create 70 households
    70.times do |i|
      h = Household.new
      h.street = Faker::Address.street_address
      h.city = Faker::Address.city
      h.state = "PA"
      h.zip = %w[15120 15213 15212 15090 15237 15207 15217 15227 15203 15210].sample
      h.home_phone = rand(10 ** 10).to_s.rjust(10,'0')
      h.insurance_provider = ["UPMC", "Highmark", "HealthAmerica"].sample
      h.insurance_policy_no = rand(10 ** 10).to_s.rjust(10,'0')
      h.family_physician = "Dr. #{Faker::Name.last_name}"
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
        s.school_county = "Allegheny"
        s.gender = rand(2).zero? # i.e., can only 0 or 1 so 50-50 chance boy or girl
        s.grade_integer = (months_old/12) - 5
        s.emergency_contact_name = Faker::Name.name
        s.emergency_contact_phone = rand(10 ** 10).to_s.rjust(10,'0')
        s.birth_certificate = "#{s.last_name}#{s.first_name}.pdf"
        if rand(4).zero?
          s.allergies = "#{rand(2).zero? ? 'Peanuts' : 'Bee stings'}"
        else
          s.allergies = "None that are known"
        end
        if rand(4).zero?
          s.medications = "Inhaler"
        else
          s.medications = "None"
        end
        s.security_question = "What is the answer to Life, the Universe and Everything?"
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

    
    index_of_team_to_be_created = 0
    team_names = Registration::TEAMS_LIST.map{|team| team[0]}
    
    #Create 4 boys brackets
    4.times do |k|
      b = Bracket.new
      min_age = 7
      max_age = 9
      b.min_age = min_age
      b.max_age = max_age
      b.gender = true
      b.tournament_id = tourn.id
      min_age += 3
      max_age += 3
      b.save!
      puts "Added boys bracket with minimum age #{b.min_age} and maximum age #{b.max_age}"
      
      eligible_boy_students = Student.active.male.ages_between(b.min_age,b.max_age)
      #not doing anything for students left not on a team here
      num_teams_to_create = eligible_boy_students.size / 10
      num_teams_created = 0
      while num_teams_created < num_teams_to_create do
        #add new team
        t = Team.new
        if index_of_team_to_be_created < team_names.size
          t.name = team_names[index_of_team_to_be_created]
        else
          t.name = team_names[index_of_team_to_be_created % team_names.size] +
              index_of_team_to_be_created
        end
        t.max_students = 10
        t.bracket_id = b.id
        t.save!
        puts "Added team #{t.name}"
        num_teams_created += 1
        index_of_team_to_be_created += 1
            
        for current_student_index in 0..t.max_students-1 do
          student = eligible_boy_students[current_student_index]
          #add new registration
          r = Registration.new
          weeks_old = (0..52).to_a.sample
          r.physical = "#{student.last_name}physical.pdf"
          r.physical_date = weeks_old.months.ago.to_date
          r.proof_of_insurance = "#{student.last_name}insurance.pdf"
          r.report_card = "#{student.last_name}report_card.pdf"
          r.student_id = student.id
          r.t_shirt_size = (1..6).to_a.sample
          r.team_id = t.id
          r.active = true
          r.save!
          puts "Registered #{student.proper_name} to the #{t.name}"
        end
      end
    end
    
    #Create 2 girls brackets
     2.times do |l|
      b = Bracket.new
      min_age = 7
      max_age = 12
      b.min_age = min_age
      b.max_age = max_age
      b.gender = false
      b.tournament_id = tourn.id
      min_age += 6
      max_age += 6
      b.save!
      puts "Added girls bracket with minimum age #{b.min_age} and maximum age #{b.max_age}"
      
      eligible_girl_students = Student.active.female.ages_between(b.min_age,b.max_age)
      #not doing anything for students left not on a team here
      num_teams_to_create = eligible_girl_students.size / 10
      num_teams_created = 0
      while num_teams_created < num_teams_to_create do
        #add new team
        t = Team.new
        if index_of_team_to_be_created < team_names.size
          t.name = team_names[index_of_team_to_be_created]
        else
          t.name = team_names[index_of_team_to_be_created % team_names.size] +
              index_of_team_to_be_created
        end
        t.max_students = 10
        t.bracket_id = b.id
        t.save!
        puts "Added team #{t.name}"

        num_teams_created += 1
        index_of_team_to_be_created += 1
            
        for current_student_index in 0..t.max_students-1 do
          student = eligible_girl_students[current_student_index]
          #add new registration
          r = Registration.new
          days_old = (0..360).to_a.sample
          r.physical = "#{student.last_name}physical.pdf"
          r.physical_date = days_old.months.ago.to_date
          r.proof_of_insurance = "#{student.last_name}insurance.pdf"
          r.report_card = "#{student.last_name}report_card.pdf"
          r.student_id = student.id
          r.t_shirt_size = (1..6).to_a.sample
          r.team_id = t.id
          r.active = true
          r.save!
          puts "Registered #{student.proper_name} to the #{t.name}"
        end
      end
    end
  end
end