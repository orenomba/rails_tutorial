# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string(255)      not null
#  email                        :string(255)      not null
#  crypted_password             :string(255)
#  salt                         :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#  avatar_file_name             :string(255)
#  avatar_content_type          :string(255)
#  avatar_file_size             :integer
#  avatar_updated_at            :datetime
#

class EmailAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || I18n.t("activerecord.errors.messages.invalid"))
    end
  end
end

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessor :remove_avatar
  attr_accessible :name, :email, :password, :password_confirmation, :avatar, :remove_avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates :name, :email, presence: true, uniqueness: true
  validates :name, :format => { 
    :with => /\A[a-zA-Z\d_]+\z/, 
    :message => I18n.t("activerecord.errors.messages.invalid") 
  }
  validates :email, email_address: true
  validates :name, length: { in: 4..50 }
  validates :password, length: { in: 8..20 }, :if => :password?
  validates :password, presence: {on: :create}
  validates :password, confirmation: true, :if => :password?
  
  before_save :should_remove_avatar?, :if => :remove_avatar?
  
  class << self
    def name?(guess)
      guess.strip!
      
      if guess =~ /@/
        user = find_by_email guess 
      else
        user = find_by_name guess
      end
      
      return user.name if user
    end
  end
  
  private
    def password?
      password.present?
    end
    
    def remove_avatar?
      not @remove_avatar.to_i.zero?
    end
    
    def should_remove_avatar?
      self.avatar.destroy
      
      true
    end
end
