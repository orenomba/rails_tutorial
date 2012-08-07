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
end

