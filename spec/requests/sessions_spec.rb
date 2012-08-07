# encoding: utf-8
require 'spec_helper'

describe "sessions" do
  
  describe "new" do
    before(:each) do
      visit login_path
    end
    
    it "should show page" do
      page.should have_content "ログイン"
    end
  end
  
  describe "create" do
    before(:each) do
      visit login_path
    end
    
    it "should show errors" do
      click_button "ログイン"
      page.should have_selector "div.error", count: 2
    end
    
    describe "login" do
      before(:each) do
        FactoryGirl.create :user, name: "test", email: "test@domain.local", password: "a" * 8
      end
  
      it "should show error if not authorized" do
        fill_in "session_identification", with: "not a user"
        fill_in "session_password", with: "a" * 8
        click_button "ログイン"
        
        page.should have_content "認証できませんでした"
      end
      
      it "should login by user_name" do
        fill_in "session_identification", with: "test"
        fill_in "session_password", with: "a" * 8
        click_button "ログイン"
        
        page.should have_content "ログインしました"
      end
      
      it "should login by email" do
        fill_in "session_identification", with: "test@domain.local"
        fill_in "session_password", with: "a" * 8
        click_button "ログイン"
        
        page.should have_content "ログインしました"
      end
    end
  end

  describe "destroy" do
    before(:each) do
      visit login_path
      FactoryGirl.create :user, name: "test", email: "test@domain.local", password: "a" * 8
      fill_in "session_identification", with: "test"
      fill_in "session_password", with: "a" * 8
      click_button "ログイン"
    end
    
    it "should logout" do
      click_on "ログアウト"
      page.should_not have_content "ログアウト"
    end
  end
end

