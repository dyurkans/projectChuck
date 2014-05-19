class HouseholdsController < ApplicationController
  require 'will_paginate/array'
  
  before_filter :check_login
  authorize_resource
  
  def new
    @household = Household.new
  end
  
  def create
    @household = Household.new(params[:household])
    if @household.save
      # if saved to database
      flash[:notice] = "Successfully created the #{@household.name} Household."
      redirect_to @household # go to show household page
    else
      # go back to the 'new' form
      render :action => 'new'
    end
  end
  
  def edit
    @household = Household.find(params[:id])
  end
  
  def index
    @active_households = Household.active
    @inactive_households = Household.inactive
    households_with_guardians = Household.active.by_last_name
    households_without_guardians = Household.all - households_with_guardians
    @all_households = (households_without_guardians + households_with_guardians)
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
      s.save!
      regs = s.registrations.current
      unless regs.nil? || regs.empty?
        for r in regs
          r.active = false
          r.save!
        end
      end
    end
    @household.save!
    flash[:notice] = "Successfully deactivated the  #{@household.name} Household from the Project C.H.U.C.K. System"
    redirect_to @household
  end
  
  def activate_household
    @household = Household.find(params[:id])
    @household.active = true
    @household.save! 
    for g in @household.guardians
      g.active = true
      g.save!
    end
    for s in @household.students
      s.active = true
      s.save!
      regs = s.registrations.current
      unless regs.nil? || regs.empty?
        for r in regs
          r.active = true
          r.save!
        end
      end
    end
    flash[:notice] = "Successfully reactivated #{@household.name} Household in the Project C.H.U.C.K. System"
    redirect_to @household
  end

end
