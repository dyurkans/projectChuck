class TeamsController < ApplicationController

  def new
    @team = Team.new
  end
  
  def edit
    @team = Team.find(params[:id])
  end
  
  def index
    @teams = Team.alphabetical.paginate(:page => params[:page]).per_page(10)  
  end
  
  def show
  	@team = Team.find(params[:id])
  	@bracket = Bracket.find_by_id(@team.bracket_id) unless @team.nil?
  	@registrations = Registration.where(:team_id => @team.id) unless Registration.where(:team_id => @team.id).nil?
  	@students = []
  	if !@registrations.nil?
  		for reg in @registrations do  
  			@students << Student.where(:id => reg.student_id)[0]
  		end
  	end
  end
  
  def create
    @team = Team.new(params[:team])
    if @team.save
      # if saved to database
      flash[:notice] = "Successfully created #{@team.name}."
      redirect_to @team # go to show team page
    else
      # return to the 'new' form
      flash[:notice] = "failed"
      render :action => 'new'
    end
  end
  
  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:notice] = "Successfully updated #{@team.name}."
      redirect_to @team
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    flash[:notice] = "Successfully removed #{@team.name} from the Project C.H.U.C.K. System"
    redirect_to teams_url
  end

end