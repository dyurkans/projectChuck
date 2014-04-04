class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
    @student = Student.new
  end
  
  def create
    @student = Student.new(params[:student])
    @registration = Registration.new(params[:registration])
    if @registration.save
      # if saved to database
      flash[:notice] = "Successfully created registration for #{Student.find_by_id(@registration.student_id)}."
      redirect_to @student # go to show student page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end
end
