class GuardiansController < ApplicationController
  require 'will_paginate/array'
  
  before_filter :check_login
  authorize_resource
  
  def new
    @guardian = Guardian.new
    households_with_guardians = Household.active.by_last_name
    households_without_guardians = Household.all - households_with_guardians
    @households = households_without_guardians + households_with_guardians
  end
  
  def create
    @guardian = Guardian.new(params[:guardian])
    @household = Household.find(@guardian.household_id)
    @households = Household.active.by_last_name
    if @guardian.save
      # if saved to database
      flash[:notice] = "Successfully created #{@guardian.name}."
      redirect_to @guardian # go to show student page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end
  
  def edit
    @guardian = Guardian.find(params[:id])
    @household = Household.find(@guardian.household_id)
    @households = Household.active.by_last_name
  end
  
  def index
    @active_guardians = Guardian.active.paginate(:page => params[:page]).per_page(10)
    @inactive_guardians = Guardian.inactive.paginate(:page => params[:page]).per_page(10)
    @all_guardians = Guardian.alphabetical.paginate(:page => params[:page]).per_page(10)
  end
  
  def show
    @guardian = Guardian.find(params[:id])
    @students = @guardian.students
    @household = Household.find(@guardian.household_id)
    #@household = Household.select{ |h| h.id == @guardian.household_id }.first.map { |h| h.name }
  end
  
  def update
    @guardian = Guardian.find(params[:id])
    @households = Household.active.by_last_name
    @household = Household.find(@guardian.household_id)
    #@household = Household.select{ |h| h.id == @guardian.household_id }.first
    if @guardian.update_attributes(params[:guardian])
      flash[:notice] = "Successfully updated the #{@guardian.name}."
      redirect_to @guardian
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @guardian = Guardian.find(params[:id])
    @household = Household.select{ |h| h.id == @guardian.household_id }.first
    @guardian.active = false
    @guardian.save!
    flash[:notice] = "Successfully deactivated #{@guardian.name} from the Project C.H.U.C.K. System"
    redirect_to @guardian
  end

  def activate_guardian
    @guardian = Guardian.find(params[:id])
    @guardian.active = true
    @guardian.save!
    flash[:notice] = "Successfully reactivated #{@guardian.name} from the Project C.H.U.C.K. System"
    redirect_to @guardian
  end

end
