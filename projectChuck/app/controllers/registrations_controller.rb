class RegistrationsController < ApplicationController
  def new
    @registration_form = reg_form
  end

  def create
    @registration = reg_form

    if @registration_form.save
      # if saved to database
      @student = Student.find_by_id(@registration.student_id)
      flash[:notice] = "Successfully created registration for #{@student.proper_name}."
      redirect_to # go to show student page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  private

    def reg_form
      RegistrationForm.new(guardian: Guardian.new, household: Household.new, student: Student.new, registration: Registration.new)
    end
  
end
