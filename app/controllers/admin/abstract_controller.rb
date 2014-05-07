class Admin::AbstractController < ApplicationController
  layout 'admin'
  before_action :require_login

  private

  def require_login
    unless logged_in?
      if request.xhr?
        head :forbidden
      else
        redirect_to user_login_url, alert: t('admin.not_logged_in')
      end
    end
  end
end
