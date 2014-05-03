class RegistrationsController < ApplicationController
  def new
    @registration_form = reg_form
    @household = Household.new
    @guardian = @household.guardians.build(:household_id => @household.id) if @household.guardians.empty?
    puts "Guardian household_id is: #{@guardian}"
    @student = @guardian.students.build(:household_id => @household.id) if @guardian.students.empty?
    puts "Student household_id is: #{@student}"
    @registration = @student.registrations.build(:student_id => @student.id) if @student.registrations.empty?
    puts "Registration student_id is: #{@registration}"
  end

  def index
    @registration = Registration.find(params[:id])
    @student = Student.find(@registration.student_id)
  end
  
  def create
    @registration_form = reg_form
    
#     if @registration_form.validate(params[:household]) && @registration_form.validates(params[:student]) &&
#         @registration_form.validate(params[:registration]) && @registration_form.validates(params[:guardian])
#       @registration_form.register!(params[:household], params[:guardians], params[:student], params[:registration])
#     end
    if @registration_form.persist!(all_params)
      redirect_to students_path
#         Household.create(nested[:household])
#         Guardian.create(nested[:guardian])
#         Student.create(nested[:student])
#         Registration.create(nested[:registration])
#       end
    end
    
#     @registration_form.persist!(params)
    
#     @registration_form = RegistrationForm.new(params[:registration_form])
#     @household = Household.new(params[:household])
#     params[:household][:guardians_attributes].values.each do |guardian|
#       puts "Guardian is: #{guardian}"
#       @guardian = @household.guardians.build(guardian)
#       guardian[:students_attributes].values.each do |student|
#         puts "Student is: #{@student}"
  #         @student = @guardian.students.build(student)
#         student[:registrations_attributes].values.each do |registration|
#           puts "Registration is: #{registration}" 
#           @registration = @student.registrations.build(registration)
#         end if student and student[:registrations_attributes]
#       end if guardian and guardian[:students_attributes]
#     end if params[:household] and params[:household][:guardians_attributes]
    
#     @household = Household.new(params[:household])
#     puts "Household is: #{@household}"
#     @guardian = @household.guardians.build(params[:guardian])
#     puts "Guardian is: #{@guardian}"
#     @student = @guardian.students.build(params[:student])
#     puts "Student is: #{@student}"
#     @registration = @student.registrations.build(params[:registration])
#     puts "Registration is: #{@registration}"
    
#     student = Student.find_by_id(@registration.student_id)
#     if @registration_form.persist!
#       # if saved to database
#       flash[:notice] = "Successfully created a registration for #{student.proper_name}."
#       redirect_to student_path(student)
#     else
#       # return to the 'new' form
#       render 'new'
#     end
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
      RegistrationForm.new(household: Household.new, student: Student.new, registration: Registration.new, guardian: Guardian.new)
    end
    
    def all_params
      params.require(:household)
      params.require(:guardian)
      params.require(:student)
      params.require(:registration).permit!
    end
end
