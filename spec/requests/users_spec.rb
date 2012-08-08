# encoding: utf-8
require 'spec_helper'

describe "users" do
  
  describe "new" do
    before(:each) do
      visit signup_path
    end
    
    it "should show page" do
      page.should have_content "登録"
    end
    
    describe "create" do
      before(:each) do
        visit signup_path
      end
      
      it "should show errors" do
        click_button "登録"
        page.should have_selector "div.error", count: 3
      end
      
      it "should register" do
        fill_in "user_name", with: "test"
        fill_in "user_email", with: "test@domain.local"
        fill_in "user_password", with: "a" * 8
        fill_in "user_password_confirmation", with: "a" * 8
        click_button "登録"
        
        page.should have_content "登録しました"
      end
      
      it "should be able to set avatar" do
        attach_file('user_avatar', File.join(File.dirname(__FILE__), "users", "avatar.jpg"))
        fill_in "user_name", with: "test"
        fill_in "user_email", with: "test@domain.local"
        fill_in "user_password", with: "a" * 8
        fill_in "user_password_confirmation", with: "a" * 8
        click_button "登録"
        
        User.first.avatar.should be_file
      end
    end
  end
  
  
  describe "show" do
    before(:each) do
      @user = FactoryGirl.create :user, name: "test", email: "test@domain.local", password: "a" * 8
    end
   
    describe "not logged in" do
      it "should redirect to login page" do
        visit user_path(@user)
        page.current_url.should match login_path
      end
    end
    
    describe "logged in" do
      before(:each) do
        visit login_path
        fill_in "session_identification", with: "test"
        fill_in "session_password", with: "a" * 8
        click_button "ログイン"
        visit user_path(@user)
      end

      it "should show page" do
        page.should have_content "秘密のページ"
      end
    end
  end
  
  describe "edit" do
    before(:each) do
      @user = FactoryGirl.create :user, name: "test", email: "test@domain.local", password: "a" * 8
      visit login_path
      fill_in "session_identification", with: "test"
      fill_in "session_password", with: "a" * 8
      click_button "ログイン"
      visit edit_user_path(@user)
    end
    
    it "should show page" do
      page.should have_content "編集"
    end
    
    it "should have name disabled" do
      page.should have_selector "#user_name.disabled"
    end

    describe "update" do
      it "should update" do
        lambda{
          fill_in "user_email", with: "edit@domain.local"
          click_button "編集"
          @user.reload
        }.should change(@user, :email).from("test@domain.local").to("edit@domain.local")
      end

      it "should show message" do
        click_button "編集"
        page.should have_content "編集しました"
      end
      
      it "should not update name" do
        lambda{
          fill_in "user_name", with: "changed"
          click_button "編集"
          @user.reload
        }.should_not change(@user, :name).from("test").to("changed")
      end
      
      describe "avatar" do
        before(:each) do
          @user.avatar = File.open File.join(File.dirname(__FILE__), "users", "avatar.jpg")
          @user.save!
          visit edit_user_path @user
        end
        
        it "should be able to remove avatar" do
          check "user_remove_avatar"
          click_button "編集"

          # なぜかreloadだとavatarがリロードされない
          # rails console だとちゃんとリロードされている
          # TODO @user.reload
          @user = User.find @user.id
          
          @user.avatar.should_not be_file
        end
      end
    end
  end
end

