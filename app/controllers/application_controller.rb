# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def not_authenticated
    flash[:error] = "ログインしてください"
    redirect_to login_url
  end
end
