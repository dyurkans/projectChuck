class TournamentsController < ApplicationController
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
      flash[:notice] = "Successfully created #{@tournament}."
      redirect_to @tournament # go to show Tournament page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end
  
  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(params[:tournament])
      flash[:notice] = "Successfully updated #{@tournament}."
      redirect_to @tournament
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    flash[:notice] = "Successfully removed #{@tournament} from the Project C.H.U.C.K. System"
    redirect_to tournaments_url
  end
end
