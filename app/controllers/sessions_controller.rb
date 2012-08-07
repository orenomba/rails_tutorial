# encoding: utf-8
class SessionsController < ApplicationController
  def new
    @user_session = Session.new
  end
  
  def create
    @user_session = Session.new params[:session]
    return render :new unless @user_session.valid?
    
#    user_name = User.name?(@user_session.identification)
    
    user = login(@user_session.identification, @user_session.password, @user_session.remember_me)
    if user
      redirect_back_or_to root_url, success: "ログインしました"
    else
      flash.now[:error] = "認証できませんでした"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url
  end
end
