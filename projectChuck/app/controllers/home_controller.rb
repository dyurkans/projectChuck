class HomeController < ApplicationController

	require 'will_paginate/array'

	def index
		@students_missing_docs = Student.active.alphabetical.without_forms.paginate(:page => params[:page]).per_page(10)
		@registrations = Registration.all
		@guardians_receiving_texts = Guardian.active.alphabetical.receive_text_notifications.paginate(:page => params[:page]).per_page(10)
		@students = Student.active.alphabetical.paginate(:page => params[:missing_docs_page]).per_page(10)
		@household = Household.all
		@tournament = Tournament.by_date.first
	end
end
