class HouseholdsController < ApplicationController
  def new
    @household = Household.new
  end
  
  def create
    @household = Household.new(params[:student])
    if @household.save
      # if saved to database
      flash[:notice] = "Successfully created household."
      redirect_to @household # go to show student page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end
end
