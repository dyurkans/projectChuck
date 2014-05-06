class RegistrationsController < ApplicationController

  authorize_resource
  
  def new
#     @registration_form = reg_form
    @household = Household.new
    @guardians = @household.guardians.build
    @students = @guardians.students.build
    @students.registrations.build
  end

  def index
    @registration = Registration.find(params[:id])
    @student = Student.find(@registration.student_id)
  end
  
  def create
    @registration = Registration.new(params[:registration])
    student = Student.find_by_id(@registration.student_id)
    if @registration.save!
      # if saved to database
      flash[:notice] = "Successfully created a registration for #{student.proper_name}."
      redirect_to student_path(student)
    else
      # return to the 'new' form
      render 'new'
    end
#     @registration_form = reg_form
# 
#     puts params
#     if @registration_form.persist!(params)
#       flash[:notice] = "Successfully created registration for Steve."
#       redirect_to students_path # go to show student page
#     else
#       render :action => 'new'
#     end
  end
  

  private

    def reg_form
      RegistrationForm.new(guardian: Guardian.new, household: Household.new, student: Student.new, registration: Registration.new)
    end
    
end
