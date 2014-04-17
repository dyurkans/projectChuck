class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def index
    @registration = Registration.find(params[:id])
    @student = Student.find(@registration.student_id)
  end
  
  def create
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
