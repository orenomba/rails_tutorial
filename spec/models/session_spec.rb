require 'spec_helper'

describe Session do
  it "should have identification" do
    FactoryGirl.build(:session).should respond_to :identification
  end

  it "should have password" do
    FactoryGirl.build(:session).should respond_to :password
  end

  it "should have remember_me" do
    FactoryGirl.build(:session).should respond_to :remember_me
  end
  
  describe "on valid?" do
    it "should have an identification" do
      FactoryGirl.build(:session, identification: "     ").should_not be_valid
    end

    it "should have a password" do
      FactoryGirl.build(:session, password: "     ").should_not be_valid
    end
  end
end