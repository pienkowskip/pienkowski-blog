class User::SessionsController < ApplicationController
  layout 'user'

  def new
    redirect_to admin_root_url if logged_in?
  end

  def create
    params[:login].strip!
    user = login(params[:login], params[:password], params[:remember_me])
    if user
      redirect_back_or_to admin_root_url
    else
      flash.now[:alert] = t('.failure')
      render action: :new
    end
  end

  def destroy
    if logged_in?
      logout
      redirect_to user_login_url, notice: t('.success')
    else
      redirect_to user_login_url, alert: t('.failure')
    end
  end
end
