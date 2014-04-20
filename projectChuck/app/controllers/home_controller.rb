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
		


		###########################################################
		# #Gender Demogrpahics
		# for stu in @registered_students
		# 	if @students.find(r.student_id).gender
		# 		@male_students += 1
		# 	else 
		# 		@female_students += 1
		# 	end
		# end
		# ###########################################################
		# #School District Demographics
		# @school_districts = []
		# for stu in @registered_students
		# 	@school_districts << [@students.find(r.student_id).school_county]
		# end
		# #Unique list of all school districts
		# @uniq_school_districts = @school_districts.uniq
		# @all_school_districts = 0
		# for r in @registrations
		# 	@all_school_districts << [@students.find(r.student_id).school_county]
		# end











		# Documentation can be found at https://github.com/michelson/lazy_high_charts
		@chart = LazyHighCharts::HighChart.new('pie') do |f|
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
	end


end
