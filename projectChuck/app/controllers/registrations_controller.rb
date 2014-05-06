class RegistrationsController < ApplicationController

  authorize_resource
  
  def new
#     @registration_form = reg_form
    @household = Household.new
    @guardians = @household.guardians.build
    @students = @household.students.build
    @students.registrations.build
  end

  def index
    @registration = Registration.find(params[:id])
    @student = Student.find(@registration.student_id)
  end
  
  def create
    @household = Household.new(params[:household])
    #@registration = Registration.new(params[:registration])
    #@student = Student.find(@registration.student_id)
    if @household.save!
      # if saved to database
      flash[:notice] = "Successfully created a registration for ."
      redirect_to home_path
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
