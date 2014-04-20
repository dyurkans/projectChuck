class HomeController < ApplicationController

	require 'will_paginate/array'

	def index
		@tournament = Tournament.by_date.first
		@students_missing_docs = Student.active.alphabetical.without_forms.paginate(:page => params[:page]).per_page(10)
		@guardians_receiving_texts = Guardian.active.alphabetical.receive_text_notifications.paginate(:page => params[:page]).per_page(10)
		@registrations = Registration.active
		@students = Student.active.alphabetical.paginate(:page => params[:missing_docs_page]).per_page(10)
		@registered_students = Student.registered_students
		@male_students = @registered_students.select { |x| x.gender == true }.size 
		@female_students = @registered_students.select { |x| x.gender == false }.size
		@school_districts = Student.school_districts
		@unassigned_students = @registered_students.select { |stu| stu.registrations.reg_order.first.team_id == nil }.paginate(:page => params[:unassigned_student_page], :per_page => 10)
		@brackets = Bracket.all
		# for reg in Registration.current.active.by_date.select { |reg| reg.team_id == nil }
		# 	@eligible_students = lambda {|bracket| where(Student.find(reg.student_id).age_as_of_june_1 >= min and Student.find(reg.student_id).age_as_of_june_1 <= max) }
		
		# Documentation can be found at https://github.com/michelson/lazy_high_charts
		@gender_chart = LazyHighCharts::HighChart.new('pie') do |f|
		      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
		      series = {
		               :type=> 'pie',
		               :name=> 'Gender',
		               :data=> [
		                  ['Female',   @male_students ],
		                  ['Male',     @female_students ]
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
	end
end
