class SessionsController < ApplicationController
  def new
    redirect_to "/auth/#{params[:provider]}"
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if user.uid == 8596
      session[:user_id] = user.id
      redirect_to admin_url, notice: "Successfully logged in as %s." % user.name
    else
      redirect_to root_url, notice: "You are unauthorized, suck it."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out."
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
