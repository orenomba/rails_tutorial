# encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_login, :only => :show

  def new
    @user = User.new
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      flash[:success] = "ユーザー登録しました！"
      redirect_to root_url
    else
      render :new
    end
  end
end
