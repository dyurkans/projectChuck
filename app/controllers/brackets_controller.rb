class BracketsController < ApplicationController
  require 'will_paginate/array'
  
  before_filter :check_login
  authorize_resource

  def new
    @bracket = Bracket.new
  end
  
  def edit
    @bracket = Bracket.find(params[:id])
  end
  
  def index
    @brackets = Bracket.by_gender.by_age.paginate(:page => params[:page]).per_page(10)  
  end
  
  def show
  	@bracket = Bracket.find(params[:id])
  	@teams = @bracket.teams.alphabetical
    @unassigned_teams = Team.select{ |t| t.bracket_id.nil? }
  end
  
  def create
    @bracket = Bracket.new(params[:bracket])
    if @bracket.save
      # if saved to database
      flash[:notice] = "Successfully created #{@bracket.name} bracket."
      redirect_to @bracket # go to show bracket page
    else
      # go back to the 'new' form
      render :action => 'new'
    end
  end

  def remove_team
    @bracket = Bracket.find(params[:id])
    @team = Team.find(params[:team_id])
    #@team.update_attribute(:bracket_id, nil)
    for reg in @team.registrations
      reg.team_id = nil
      reg.save!
    end
    @team.destroy
    redirect_to bracket_path(@bracket)
  end

  def add_team
    @bracket = Bracket.find(params[:id])
    @team = Team.find(params[:team_id])
    @team.update_attribute(:bracket_id, @bracket.id)
    @team.save!
    redirect_to bracket_path(@bracket)
  end
  
  def update
    @bracket = Bracket.find(params[:id])
    if @bracket.update_attributes(params[:bracket])
      flash[:notice] = "Successfully updated #{@bracket.name} bracket."
      redirect_to @bracket
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @bracket = Bracket.find(params[:id])
    for team in @bracket.teams
      for reg in team.registrations
        reg.team_id = nil
        reg.save!
      end
      team.bracket_id = nil
      team.destroy
    end
    @bracket.destroy
    flash[:notice] = "Successfully removed #{@bracket.name} bracket from the Project C.H.U.C.K. System"
    redirect_to brackets_url
  end
end
