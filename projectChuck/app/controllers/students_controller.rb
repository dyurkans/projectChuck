class StudentsController < ApplicationController
  def new
    @student = Student.new
  end
  
  def edit
    @student = Student.find(params[:id])
  end
  
  def index
    @students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)

  end
  
  def show
    @student = Student.find(params[:id])
    @household = Household.find_by_id(@student.household_id)
    @registration = @student.registrations.reg_order[0]
    @team = Team.find_by_id(@registration.team_id)
    @bracket = Bracket.find_by_id(@team.bracket_id)
    @guardians = @student.guardians

  end
  
  def create
    @student = Student.new(params[:student])
    if @student.save
      # if saved to database
      flash[:notice] = "Successfully created #{@student.proper_name}."
      redirect_to @student # go to show student page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end
  
  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Successfully updated #{@student.name}."
      redirect_to @student
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    flash[:notice] = "Successfully removed #{@student.proper_name} from the Project C.H.U.C.K. System"
    redirect_to students_url
  end
end