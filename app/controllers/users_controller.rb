# encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_login, :only => :show

  def new
    @user = User.new
    render :form
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      flash[:success] = "ユーザー登録しました！"
      redirect_to root_url
    else
      render :form
    end
  end
  
  def edit
    find
    render :form
  end
  
  def update
    find
    
    if @user.update_attributes(params[:user].reject{|key| key == :name})
      flash[:success] = "ユーザー編集しました！"
      redirect_to edit_user_path @user
    else
      render :form
    end
  end
  
  private 
    def find
      @user = User.find params[:id]
    end
end
