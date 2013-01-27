class UsersController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :find_registration

  def create
    @user = User.new params[:user].reverse_merge password_confirmation: params[:user][:password]
    @user.transaction_id = @registration.transaction_id

    if @user.save
      @registration.proceed
      sign_in(:user, @user)

      redirect_to @registration
    else
      flash[:alert] = @user.errors.full_messages.first
      render 'registrations/new'
    end
  end

  private
    def find_registration
      @registration = Registration.find params[:registration_id]
    end
end
