class HomeController < ApplicationController

	require 'will_paginate/array'
  
  def loaderio
    render 'loaderio', :layout => false
  end
  
	def waitlist
		@brackets = Bracket.all
		authorize! :waitlist, current_user
	end

	def export
		@guardians_receiving_texts = Guardian.active.alphabetical.receive_text_notifications
		document_columns = [:first_name, :last_name, :cell_phone]
		document_headers = ["First Name", "Last Name", "Cell Phone"]
		file = @guardians_receiving_texts.to_xls(columns: document_columns, headers: document_headers)
		respond_to do |format|
	      format.html
	      format.xls { send_data file, :filename => "Text Notifcations List.xls" }
	    end
	end
  
	def index
		if  !current_user.nil? && current_user.is_admin?
			@tournament = Tournament.by_date.first
			@guardians_receiving_texts = Guardian.active.alphabetical.receive_text_notifications
			# @registrations = Registration.active
			# @students = Student.active.alphabetical
			@current_registered_students = Student.alphabetical.current.active
			#@students_missing_docs = Student.alphabetical.missing_forms(@current_registered_students)
			@students_missing_docs = Student.alphabetical.current.without_forms.active			
			@male_students = @current_registered_students.male.size 
			@female_students = @current_registered_students.female.size
			@school_districts = Student.school_districts
			@unassigned_students = Student.active.alphabetical.unassigned
			# @brackets = Bracket.all
			@home_counties = Student.home_counties
			# for reg in Registration.current.active.by_date.select { |reg| reg.team_id == nil }
			# 	@eligible_students = lambda {|bracket| where(Student.find(reg.student_id).age_as_of_june_1 >= min and Student.find(reg.student_id).age_as_of_june_1 <= max) }


			# Documentation can be found at https://github.com/michelson/lazy_high_charts
			
			@gender_chart = LazyHighCharts::HighChart.new('pie') do |f|
			      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
			      series = {
			               :type=> 'pie',
			               :name=> 'Gender',
			               :data=> [
			                  ['Male',   @male_students ],
			                  ['Female',     @female_students ]
			               ]
			      }
			      f.series(series)
			      f.options[:title][:text] = "Registered Student Gender Distribution"
			      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			      f.plot_options(:pie=>{
			        :allowPointSelect=>true, 
			        :cursor=>"pointer" , 
			        :dataLabels=>{
			          :enabled=>true,
			          :color=>"black",
			          :style=>{
			            :font=>"13px Trebuchet MS, Verdana, sans-serif"
			          }
			        }
			      })
			end	

			@school_district_chart = LazyHighCharts::HighChart.new('pie') do |f|
			      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
			      series = {
			               :type=> 'pie',
			               :name=> 'School District',
			               :data=> @school_districts
			      }
			      f.series(series)
			      f.options[:title][:text] = "Registered Student School District Distribution"
			      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			      f.plot_options(:pie=>{
			        :allowPointSelect=>true, 
			        :cursor=>"pointer" , 
			        :dataLabels=>{
			          :enabled=>true,
			          :color=>"black",
			          :style=>{
			            :font=>"13px Trebuchet MS, Verdana, sans-serif"
			          }
			        }
			      })
			end

			@home_counties_chart = LazyHighCharts::HighChart.new('pie') do |f|
			      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
			      series = {
			               :type=> 'pie',
			               :name=> 'Home Counties',
			               :data=> @home_counties
			      }
			      f.series(series)
			      f.options[:title][:text] = "Registered Student Home County Distribution"
			      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
			      f.plot_options(:pie=>{
			        :allowPointSelect=>true, 
			        :cursor=>"pointer" , 
			        :dataLabels=>{
			          :enabled=>true,
			          :color=>"black",
			          :style=>{
			            :font=>"13px Trebuchet MS, Verdana, sans-serif"
			          }
			        }
			      })
			end	
		end		
	end
end
