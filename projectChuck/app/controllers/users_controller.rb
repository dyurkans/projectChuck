class UsersController < ApplicationController

    def index
        @users = User.paginate(:page => params[:page]).per_page(7)
        #authorize! :index, @user
    end
    
    def new
        @user = User.new
        #authorize! :new, @user
    end
    
    def edit
        @user = User.find(params[:id])
        if @user.role? == "member"
            @user.role == "member"
        end
        #authorize! :edit, @user
    end
        
    def create
        @user = User.new(params[:user])
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_url, notice: "Thank you for signing up!"
        else
            flash[:error] = "This user could not be created."
            render "new"
        end
        #authorize! :create, @user
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
        flash[:notice] = "#{@user.proper_name} is updated."
            redirect_to @user
        else
            render :action => 'edit'
        end
        #authorize! :update, @user
    end
        
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "Successfully removed #{@user.proper_name} from karate tournament system."
        redirect_to users_url
        #authorize! :destroy, @user
    end
end
