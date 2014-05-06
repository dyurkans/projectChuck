class RegistrationsController < ApplicationController
  def new
    @household = Household.new
    @guardian = @household.guardians.build(:household_id => @household.id) if @household.guardians.empty?
    @student = @household.students.build(:household_id => @household.id) if @household.students.empty?
    @registration = @student.registrations.build(:student_id => @student.id) if @student.registrations.empty?
  end

  def index
    @registration = Registration.find(params[:id])
    @student = Student.find(@registration.student_id)
  end
  
  def create
    @household = Household.new(params[:household])
    puts "Household is: #{@household}"
    
    student = @household.students.first
    if @household.save!
      # if saved to database
      flash[:notice] = "Successfully created a registration for #{student.proper_name}."
      redirect_to student_path(student)
    else
      # return to the 'new' form
      render 'new'
    end
  end
  

  private

end
