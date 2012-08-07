# encoding: utf-8
require 'spec_helper'

describe "home" do
  
  describe "index" do
    before(:each) do
      visit root_path
    end

    describe "not logged in" do
      it "should show" do
        page.should have_content "welcome"
      end

      it "should not show user links" do
        page.should_not have_content "秘密のリンク"
      end
    end
    
    describe "logged in" do
      before(:each) do
        FactoryGirl.create :user, name: "test", email: "test@domain.local", password: "a" * 8
        
        visit login_path
        fill_in "session_identification", with: "test"
        fill_in "session_password", with: "a" * 8
        click_button "ログイン"
        visit root_path
      end
      
      it "should show user links" do
        page.should have_content "秘密のリンク"
      end
    end
  end
  
end

