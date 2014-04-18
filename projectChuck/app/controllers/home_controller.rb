class HomeController < ApplicationController

	require 'will_paginate/array'

	def index
		@students_missing_docs = Student.active.alphabetical.without_forms.paginate(:page => params[:page]).per_page(10)
		@registrations = Registration.active
		@guardians_receiving_texts = Guardian.active.alphabetical.receive_text_notifications.paginate(:page => params[:page]).per_page(10)
		@students = Student.active.alphabetical.paginate(:page => params[:missing_docs_page]).per_page(10)
		@household = Household.all
		@tournament = Tournament.by_date.first
		@male_students = 0
		@female_students = 0
		for r in @registrations
			if @students.find(r.student_id).gender
				@male_students += 1
			else 
				@female_students += 1
			end
		end
		@school_districts = []
		for r in @registrations
			districts = []
			districts << [@students.find(r.student_id).school_county]
			@school_districts = districts.compact
		end

		# Documentation can be found at https://github.com/michelson/lazy_high_charts
		@chart = LazyHighCharts::HighChart.new('pie') do |f|
		      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
		      series = {
		               :type=> 'pie',
		               :name=> 'Gender Share',
		               :data=> [
		                  ['Female',   @male_students],
		                  ['Male',      @female_students]
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


		@chart = LazyHighCharts::HighChart.new('pie') do |f|
		      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
		      series = {
		               :type=> 'pie',
		               :name=> 'Gender Share',
		               :data=> [
		                  ['Female',   @male_students],
		                  ['Male',      @female_students]
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
