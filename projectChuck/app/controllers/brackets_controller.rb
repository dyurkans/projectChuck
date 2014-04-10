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
    @unassigned_teams = Team.select{ |t| t.bracket_id.nil? }
    @eligible_teams = []
    for team in @unassigned_teams
      added = true
      if team.students.empty?
        @eligible_teams << team
      else
        #Go through each student on the unassigned team
        for stu in team.students
          #If unqualified student
          if stu.age > @bracket.max_age || stu.age < @bracket.min_age
            added = false
          else 
            #if qualified, go on to next student
            next
          end
        end
        # if there we no unqualified students, add the team to eligible teams for bracket
        if added = true
          @eligible_teams << team 
        end
      end
    #Do this for each unassigned team
    end   
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
    @bracket.destroy
    flash[:notice] = "Successfully removed #{@bracket.name} bracket from the Project C.H.U.C.K. System"
    redirect_to brackets_url
  end
end
