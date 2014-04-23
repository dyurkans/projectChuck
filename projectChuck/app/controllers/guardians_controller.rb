class GuardiansController < ApplicationController

  require 'will_paginate/array'

  def new
    @guardian = Guardian.new
    @households = Household.by_last_name.map { |h| "#{h.name}" }
  end
  
  def create
    @guardian = Guardian.new(params[:household])
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
    @household = Household.select{ |h| h.id == @guardian.household_id }.first
  end
  
  def index
    @active_guardians = Guardian.active.paginate(:page => params[:page]).per_page(10)
    @inactive_guardians = Guardian.inactive.paginate(:page => params[:page]).per_page(10)
    @all_guardians = Guardian.alphabetical.paginate(:page => params[:page]).per_page(10)
  end
  
  def show
    @guardian = Guardian.find(params[:id])
    @students = @guardian.students
    @household = Household.select{ |h| h.id == @guardian.household_id }.first
  end
  
  def update
    @guardian = Guardian.find(params[:id])
    @household = Household.select{ |h| h.id == @guardian.household_id }.first
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
