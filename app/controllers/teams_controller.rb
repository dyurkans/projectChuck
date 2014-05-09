class TeamsController < ApplicationController
  include ApplicationHelper
  require 'will_paginate/array'
 
  before_filter :check_login
  authorize_resource

  def new
    @team = Team.new
    @teams = Team.unassigned_teams(nil)
  end
  
  def edit
    @team = Team.find(params[:id])
    @teams = Team.unassigned_teams(@team.name)
    @bracket = Bracket.find_by_id(@team.bracket_id)
  end
  
  def index
    @teams = Team.alphabetical.by_bracket.paginate(:page => params[:page]).per_page(10)  
  end
  
  def show
  	@team = Team.find(params[:id])
    @eligible_students = @team.eligible_students.paginate(:page => params[:page], :per_page => 10)
  	@bracket = Bracket.find_by_id(@team.bracket_id) unless @team.nil?
  	@registrations = @team.registrations
  	@students = @team.students
  end

  def remove_student
    @team = Team.find(params[:id])
    @student = Student.find(params[:student_id])
    @student.registrations.current[0].update_attribute(:team_id, nil)
    @student.save!
    redirect_to team_path(@team)
  end

  def add_student
    @team = Team.find(params[:id])
    @student = Student.find(params[:student_id])
    @student.registrations.current[0].update_attribute(:team_id, @team.id)
    @student.save!
    redirect_to team_path(@team)
  end
  
  def create
    @team = Team.new(params[:team])
    @teams = Team.unassigned_teams(@team.name)
    if @team.save
      # if saved to database
      flash[:notice] = "Successfully created the #{team_name(@team.name)}."
      redirect_to @team # go to show team page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end
  
  def update
    @team = Team.find(params[:id])
    @teams = Team.unassigned_teams(@team.name)
    @bracket = Bracket.find_by_id(@team.bracket_id)
    if @team.update_attributes(params[:team])
      flash[:notice] = "Successfully updated the #{team_name(@team.name)}."
      redirect_to @team
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @team = Team.find(params[:id])
    for reg in @team.registrations
      reg.team_id = nil
      reg.save!
    end
    @team.destroy
    flash[:notice] = "Successfully removed the #{team_name(@team.name)} from the Project C.H.U.C.K. System"
    redirect_to teams_url
  end

end