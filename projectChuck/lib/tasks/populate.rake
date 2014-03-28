namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'

    #Create a tournament
    tourn = Tournament.new
    tourn.start_date = Date.today
    tourn.end_date = tourn.start_date + 3.months
    tourn.save!
    
#     seven_nine_team_ids = [[7,9,true]]
#     ten_twelve_team_ids = [[10,12,true]]
#     thirteen_fifteen_team_ids = [[13,15,true]]
#     sixteen_eighteen_team_ids = [[16,18,true]]
#     seven_twelve_team_ids = [[7,12,false]]
#     thirteen_eighteen_team_ids = [[13,18,false]]
    
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
    end
    
    #Create 2 girls brackets
     2.times do |k|
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
    end

    bracket_ids = Bracket.all.map(&:id)
    
    #Create 30 teams
    for team_name in Registration::TEAMS_LIST do
      t = Team.new
      t.name = team_name
      t.max_students = 10
      if !rand(12).zero?
        thirteen_fifteen_team_ids << t.id
        t.bracket_id = 2
      elsif !rand(9).zero?
        sixteen_eighteen_team_ids << t.id
        t.bracket_id = 3
      elsif !rand(6).zero?
        ten_twelve_team_ids << t.id
        t.bracket_id = 1
      elsif !rand(3).zero?
        seven_twelve_team_ids << t.id
        t.bracket_id = 5
      elsif !rand(2)
        seven_nine_team_ids << t.id
        t.bracket_id = 0
      else
        thirteen_eighteen_team_ids << t.id
        t.bracket_id = 6
      end
      t.save!
    end
    
    team_ids = Team.all.map(&:id)
    
    # Step 3: add some students, and registrations
    age_ranges = [[7,9],[10,12],[13,15],[16,18],[7,12],[13,18]]
    age_ranges.each do |a_range|
      # Step 3a: add some students that are in this age
      eligible_students_ids = Array.new
      n = (50..100).to_a.sample
      n.times do
        months_old = ((a_range[0]*12+1)..(a_range[1]*12+10)).to_a.sample
        stu = Student.new
        stu.first_name = Faker::Name.first_name
        stu.last_name = Faker::Name.last_name
        stu.dob = months_old.months.ago.to_date
        stu.cell_phone = rand(10 ** 10).to_s.rjust(10,'0')
        stu.active = true
        stu.save!
        eligible_students_ids << stu.id
      end
      
        # Step 3b: add a section for each event for this age/rank range
        brackets_for_group = Array.new
        team_ids.each do |t_id|
          bracket = Section.new
          bracket.tournament_id = tourn.id
          bracket.min_age = a_range[0]
          bracket.max_age = a_range[1]
          bracket.gender = true
          bracket.active = true
          bracket.save!
          brackets_for_group << brackets
        end
        
        # Step 3c: register some, most or all students for the sections just created
        eligible_students_ids.each do |e_stu_id|
        # almost everyone is in forms event
        unless rand(9).zero?
          reg = Registration.new
          reg.student_id = e_stu_id
          reg.team_id = brackets_for_group.select{|b| b.min_age == 13 && b.max_ag == 15}.first.id
          reg.created_at = (2..16).to_a.sample.days.ago.to_date
          reg.save!
        end
        
    end
    end
    
    
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
      
      #add registrations
      r = Registration.new
      months_old = (0..13).to_a.sample
      r.physical = "#{s.last_name}physical.pdf"
      r.physical_date = months_old.months.ago.to_date
      r.proof_of_insurance = "#{s.last_name}insurance.pdf"
      r.report_card = "#{s.last_name}report_card.pdf"
      r.student_id = 
      r.t_shirt_size = rand(7)
      r.team_id = 
      r.active = true
    end
  end
end