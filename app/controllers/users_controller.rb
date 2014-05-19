class UsersController < ApplicationController

  require 'will_paginate/array'
  before_filter :check_login
  authorize_resource

    def index
        @users = User.alphabetical  
    end

    def new
        @user = User.new
        @guardians = User.eligible_guardians(@guardian)
    end

    def show
        @user = User.find(params[:id])
        if current_user.role != 'admin' && current_user.email != @user.email
            redirect_to home_path 
        end
        @guardian = Guardian.find(@user.guardian_id)
    end

    def edit
        @user = User.find(params[:id])
        @guardian = Guardian.find(@user.guardian_id)
        @guardians = User.eligible_guardians(@guardian)
        # if @user.role? == "member"
        #     @user.role == "member"
        # end
    end
        
    def create
        @user = User.new(params[:user])
        @guardian = Guardian.find(@user.guardian_id)
        @guardians = User.eligible_guardians(@guardian)
        if @user.save
          flash[:notice] = "#{@user.role == "admin" ? "An admin" : "A member" } account for #{@guardian.proper_name} has successfully been created."
          redirect_to @user
        else
            flash[:error] = "This user could not be created."
            render "new"
        end
    end

    def update
        @user = User.find(params[:id])
        @guardian = Guardian.find(@user.guardian_id)
        @guardians = User.eligible_guardians(@guardian)
        if @user.update_attributes(params[:user])
          flash[:notice] = "#{@guardian.proper_name}'s user account has been updated."
          redirect_to @user
        else
            render :action => 'edit'
        end
    end
        
    def destroy
        @user = User.find(params[:id])
        @guardian = Guardian.find(@user.guardian_id)
        @user.destroy
        flash[:notice] = "Successfully removed #{@guardian.proper_name}'s user account has been removed from Project C.H.U.C.K."
        redirect_to users_url
    end
 
end
