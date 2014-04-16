namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
    puts "Deleting all previously made entities..."
    [Tournament, Registration, Student, Guardian, Household, User, Bracket, Team].each(&:delete_all)
    puts "All previously made entities have been deleted!"

    #Create a tournament
    tourn = Tournament.new
    tourn.start_date = Date.today
    tourn.end_date = tourn.start_date + 3.months
    tourn.save!
    
    
    # Create 70 households with no more than 280 students
    70.times do |i|
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
        months_old = (96..216).to_a.sample
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
        s.birth_certificate.store!(File.open(File.expand_path("./public/example_files/birth_certificate.pdf")))
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

    
    index_of_boys_team_to_be_created = 0
    boys_team_names = Team::BOYS_TEAM_LIST.map{|team| team[1]}
    
    boys_min_age = 7
    boys_max_age = 9
    eligible_boy_students_left = []
    #Create 4 boys brackets
    4.times do |k|
      b = Bracket.new
      b.min_age = boys_min_age
      b.max_age = boys_max_age
      b.gender = true
      b.tournament_id = tourn.id
      boys_min_age += 3
      boys_max_age += 3
      b.save!
      puts "Added boys bracket with minimum age #{b.min_age} and maximum age #{b.max_age}"
      
      eligible_boy_students = Student.active.male.ages_between(b.min_age,b.max_age)
      MAX_BOY_STUDENTS = 10
      num_teams_to_create = eligible_boy_students.size / MAX_BOY_STUDENTS
      num_teams_to_create += 1 if eligible_boy_students.size % MAX_BOY_STUDENTS != 0
      puts "Creating #{num_teams_to_create} teams..."
      num_teams_created = 0
      index_of_current_boy_student = 0
      while num_teams_created < num_teams_to_create do
        team_name = boys_team_names[index_of_boys_team_to_be_created]
        #add new team
        t = Team.new
        if index_of_boys_team_to_be_created < boys_team_names.size
          t.name = team_name
        else
          team_name = boys_team_names[index_of_boys_team_to_be_created % boys_team_names.size]
          t.name = "%s %d" % [team_name, index_of_boys_team_to_be_created]
        end
        t.max_students = MAX_BOY_STUDENTS
        t.bracket_id = b.id
        t.coach = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
        t.save!
        puts "Added team #{t.name}"
        num_teams_created += 1
        index_of_boys_team_to_be_created += 1
        num_boys_registered_to_t = 0
            
        while index_of_current_boy_student < eligible_boy_students.size &&
            num_boys_registered_to_t < t.max_students do
          student = eligible_boy_students[index_of_current_boy_student]
          #add new registration
          r = Registration.new
          weeks_old = (0..52).to_a.sample
          r.physical.store!(File.open(File.expand_path("./public/example_files/physical.pdf")))
          r.physical_date = (Date.new(Date.today.year-1,8,1)..Date.today).to_a.sample
          r.proof_of_insurance.store!(File.open(File.expand_path("./public/example_files/insurance.pdf")))
          r.report_card.store!(File.open(File.expand_path("./public/example_files/report_card.pdf")))
          r.student_id = student.id
          r.t_shirt_size = (0..5).to_a.sample
          if num_teams_created == num_teams_to_create
            r.team_id = nil
          else
            r.team_id = t.id
          end
          r.active = true
          r.created_at = (0..56).to_a.sample.days.ago.to_date
          r.save!
          num_boys_registered_to_t += 1
          index_of_current_boy_student += 1
          if r._team_id.nil?
            puts "Left #{student.proper_name} unregistered!"
          else
            puts "Registered #{student.proper_name} to the #{t.name}"
          end
        end
      end
    end

    
    index_of_girls_team_to_be_created = 0
    girls_team_names = Team::GIRLS_TEAM_LIST.map{|team| team[1]}
    
    girls_min_age = 7
    girls_max_age = 12
    #Create 2 girls brackets
    2.times do |l|
      b = Bracket.new
      b.min_age = girls_min_age
      b.max_age = girls_max_age
      b.gender = false
      b.tournament_id = tourn.id
      b.save!
      girls_min_age += 6
      girls_max_age += 6
      puts "Added girls bracket with minimum age #{b.min_age} and maximum age #{b.max_age}"
      
      eligible_girl_students = Student.active.female.ages_between(b.min_age,b.max_age)
      MAX_GIRL_STUDENTS = 10
      num_teams_to_create = eligible_girl_students.size / MAX_GIRL_STUDENTS
      num_teams_to_create += 1 unless ((eligible_girl_students.size % MAX_GIRL_STUDENTS).zero?)
      puts "Creating #{num_teams_to_create} teams..."
      num_teams_created = 0
      index_of_current_girl_student = 0
      while num_teams_created < num_teams_to_create do
        team_name = girls_team_names[index_of_girls_team_to_be_created]
        #add new team
        t = Team.new
        if index_of_girls_team_to_be_created < girls_team_names.size
          t.name = team_name
        else
          team_name = girls_team_names[index_of_girls_team_to_be_created % girls_team_names.size]
          t.name = "%s %d" % [team_name, index_of_team_to_be_created]
        end
        t.max_students = MAX_GIRL_STUDENTS
        t.bracket_id = b.id
        t.coach = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
        t.save!
        puts "Added team #{t.name}"

        num_teams_created += 1
        index_of_girls_team_to_be_created += 1
        num_girls_registered_to_t = 0
           
        while index_of_current_girl_student < eligible_girl_students.size &&
            num_girls_registered_to_t < t.max_students do
          student = eligible_girl_students[index_of_current_girl_student]
          #add new registration
          r = Registration.new
          days_old = (0..360).to_a.sample
          r.physical.store!(File.open(File.expand_path("./public/example_files/physical.pdf")))
          r.physical_date = (Date.new(Date.today.year-1,8,1)..Date.today).to_a.sample
          r.proof_of_insurance.store!(File.open(File.expand_path("./public/example_files/insurance.pdf")))
          r.report_card.store!(File.open(File.expand_path("./public/example_files/report_card.pdf")))
          r.student_id = student.id
          r.t_shirt_size = (0..5).to_a.sample
          if num_teams_created == num_teams_to_create
            r.team_id = nil
          else
            r.team_id = t.id
          end
          r.active = true
          r.created_at = (0..56).to_a.sample.days.ago.to_date
          r.save!
          num_girls_registered_to_t += 1
          index_of_current_girl_student += 1
          if r._team_id.nil?
            puts "Left #{student.proper_name} unregistered!"
          else
            puts "Registered #{student.proper_name} to the #{t.name}"
          end
        end
      end
    end
  end
end