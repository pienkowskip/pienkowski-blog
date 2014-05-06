class User::SessionsController < ApplicationController
  layout 'user'

  def new
    #redirect_to admin_root_path if logged_in?
  end

  def create
    params[:login].strip!
    user = login(params[:login], params[:password], params[:remember_me])
    if user
      redirect_back_or_to user_login_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render action: :new
    end
  end

  def destroy
    if logged_in?
      logout
      redirect_to user_login_path, notice: t('.success')
    else
      redirect_to user_login_path, alert: t('.failure')
    end
  end
end
