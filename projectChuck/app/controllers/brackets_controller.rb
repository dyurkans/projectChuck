class BracketsController < ApplicationController

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
  	@teams = @bracket.teams
  end
  
  def create
    @bracket = Bracket.new(params[:bracket])
    if @bracket.save
      # if saved to database
      flash[:notice] = "Successfully created #{@bracket.name} bracket."
      redirect_to @bracket # go to show bracket page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def remove_team
    @bracket = Bracket.find(params[:id])
    @team = Team.find(params[:team_id])
    @team.update_attribute(:bracket_id, nil)
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
    @bracket.destroy
    flash[:notice] = "Successfully removed #{@bracket.name} bracket from the Project C.H.U.C.K. System"
    redirect_to brackets_url
  end
end
