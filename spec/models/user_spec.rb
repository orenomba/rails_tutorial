require 'spec_helper'

describe User do
  it "should be valid" do
    FactoryGirl.build(:user).should be_valid
  end
  
  it "should have name" do
    FactoryGirl.build(:user).should respond_to :name
  end
  
  it "should have email" do
    FactoryGirl.build(:user).should respond_to :email
  end

  it "should have password" do
    FactoryGirl.build(:user).should respond_to :password
  end

  it "should have password confirmation" do
    FactoryGirl.build(:user).should respond_to :password_confirmation
  end
  
  it "should have unique name" do
    FactoryGirl.create(:user, name: "test")
    FactoryGirl.build(:user, name: "test").should_not be_valid
  end
  
  it "should have uniqe email" do
    FactoryGirl.create(:user, email: "test@domain.local")
    FactoryGirl.build(:user, email: "test@domain.local").should_not be_valid
  end

  it "should check email format" do
    FactoryGirl.build(:user, email: "test").should_not be_valid
  end
  
  describe "on create" do
    it "should have a name" do
      FactoryGirl.build(:user, name: "   ").should_not be_valid
    end

    it "should have an email" do
      FactoryGirl.build(:user, email: "   ").should_not be_valid
    end
    
    it "should have a password" do
      FactoryGirl.build(:user, password: "    ").should_not be_valid
    end
    
    it "should have a name at least 4 letter long" do
      chars = "a" * 3
      FactoryGirl.build(:user, name: chars).should_not be_valid
    end
    
    it "should have a name in a format" do
      chars = "/" * 8
      FactoryGirl.build(:user, name: chars).should_not be_valid
    end
    
    it "should have a name no more than 50 letter long" do
      chars = "a" * 51
      FactoryGirl.build(:user, name: chars).should_not be_valid
    end
    
    it "should have a password at least 8 letter long" do
      pw = "a" * 7
      FactoryGirl.build(:user, password: pw, password_confirmation: pw).should_not be_valid
    end

    it "should have a password no more than 20 letter long" do
      pw = "a" * 21
      FactoryGirl.build(:user, password: pw, password_confirmation: pw).should_not be_valid
    end
  end
  
  describe "on update" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "won't require a password" do
      @user.password = ""
      @user.should be_valid
    end
    
    describe "if password is set" do
      before(:each) do
        @user.password = "x" * 8
        @user.password_confirmation = @user.password
      end

      it "should have length" do
        @user.password = "x" * 3
        @user.password_confirmation = @user.password
        @user.should_not be_valid
      end
      
      it "should have confirmation" do
        @user.password = "x" * 8
        @user.password_confirmation = "a" * 8
        @user.should_not be_valid
      end
    end
    
    it "should remove avatar by remove_avatar attribute" do
      @user.avatar = File.open File.join(File.dirname(__FILE__), "user", "avatar.jpg")
      @user.save!
      @user.avatar.should be_file

      @user.update_attributes({"remove_avatar" => "1"})
      @user.avatar.should_not be_file
    end
  end
  
  describe "name?" do
    it "should find name from email" do
      saved = FactoryGirl.create(:user, email: "test@domain.local")
      User.name?("test@domain.local").should == saved.name
    end
    
    it "should return nil when not found" do
      User.name?("not name, not email").should be_nil
    end
  end
  
end
