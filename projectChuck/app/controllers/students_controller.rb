class StudentsController < ApplicationController
  def new
    @student = Student.new
    @student.registrations.build
    @household = Household.new
  end
  
  def edit
    @student = Student.find(params[:id])
  end
  
  def index
    @students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
    @all_students = Student.alphabetical.paginate(:page => params[:page]).per_page(15)
  end
  
  def show
    @student = Student.find(params[:id])
    @household = Household.find_by_id(@student.household_id)
    @registration = @student.registrations.reg_order[0] 
    @team = Team.find_by_id(@registration.team_id) unless @registration.nil?
    @bracket = Bracket.find_by_id(@team.bracket_id) unless @team.nil?
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
    @student.deactivate_student_and_registrations
    flash[:notice] = "Successfully deactivated #{@student.proper_name} from the Project C.H.U.C.K. System"
    redirect_to @student
  end

  def activate
    @student = Student.find(params[:id])
    @student.active = true
    @student.save! 
    unless @student.registrations.nil? || @student.registrations.empty?
      for reg in @student.registrations.inactive
        reg.update_attribute(:active, true)
        reg.save!
      end      
    end
    flash[:notice] = "Successfully reactivated #{@student.proper_name} from the Project C.H.U.C.K. System"
    redirect_to @student
  end


end