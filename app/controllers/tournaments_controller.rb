class TournamentsController < ApplicationController
  before_filter :check_login

  authorize_resource

  def new
    @tournament = Tournament.new
  end
  
  def edit
    @tournament = Tournament.find(params[:id])
  end
  
  def index
    @tournaments = Tournament.by_date.paginate(:page => params[:page]).per_page(10)
  end
  
  def show
    @tournament = Tournament.find(params[:id])
    @brackets = @tournament.brackets
  end
  
  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      # if saved to database
      flash[:notice] = "Successfully created #{@tournament.name}."
      redirect_to @tournament # go to show Tournament page
    else
      # go back to the 'new' form
      render :action => 'new'
    end
  end
  
  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = "Successfully updated #{@tournament.name}."
      redirect_to @tournament
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @tournament = Tournament.find(params[:id])
    @brackets = @tournament.brackets
    for b in @brackets
      for t in b.teams
        for r in t.registrations
          r.team_id = nil
          r.save!
        end
        t.destroy
      end
      b.destroy
    end
    @tournament.destroy
    flash[:notice] = "Successfully removed #{@tournament.name} from the Project C.H.U.C.K. System"
    redirect_to tournaments_url
  end
end
