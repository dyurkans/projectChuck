class HouseholdsController < ApplicationController
  require 'will_paginate/array'
  
  before_filter :check_login
  authorize_resource
  
  def new
    @household = Household.new
  end
  
  def create
    @household = Household.new(params[:household])
    if @household.save!
      # if saved to database
      flash[:notice] = "Successfully created #{@household.name}."
      redirect_to @household # go to show household page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end
  
  def edit
    @household = Household.find(params[:id])
  end
  
  def index
    @active_households = Household.active.paginate(:page => params[:page]).per_page(10)
    @inactive_households = Household.inactive.paginate(:page => params[:page]).per_page(10)
    @all_households = Household.by_last_name.paginate(:page => params[:page]).per_page(10)
  end
  
  def show
    @household = Household.find(params[:id])
    @guardians = @household.guardians
    @students = @household.students
  end
  
  def update
    @household = Household.find(params[:id])
    if @household.update_attributes(params[:household])
      flash[:notice] = "Successfully updated the #{@household.name} household."
      redirect_to @household
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @household = Household.find(params[:id])
    @household.active = false
    for g in @household.guardians
      g.active = false
      g.save!
    end
    for s in @household.students
      s.active = false
      r = s.registrations.current[0]
      r.active = false unless r.nil?
      r.save! unless r.nil?
      s.save!
    end
    @household.save!
    flash[:notice] = "Successfully deactivated the  #{@household.name} Household from the Project C.H.U.C.K. System"
    redirect_to household_url
  end

end
