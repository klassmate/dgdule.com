class RegistrationsController < ApplicationController
  skip_before_filter :authenticate_user!, except: [:update]
  layout 'welcome'

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]

    if @user.save
      sign_in(:user, @user)
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages.first
      render :new
    end
  end
end
