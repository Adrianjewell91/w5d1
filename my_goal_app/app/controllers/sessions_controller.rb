class SessionsController < ApplicationController
  def new
    logout! if signed_in?
    @users = User.all
  end

  def create
    # fail
    @user = User.find_by_credentials(params[:user][:email],
                                    params[:user][:password])

    if @user.nil?
      flash[:errors] = ['error']
      render :new
    else
      sign_in!(@user)
      redirect_to users_url
    end

  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end
end
