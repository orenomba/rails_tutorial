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
  attr_accessible :name, :email, :password, :password_confirmation
  
  
  validates :name, :email, presence: true, uniqueness: true
  validates :email, email_address: true
  validates :name, length: { in: 4..50 }
  validates :password, confirmation: true, length: { in: 8..20 }
  
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
end
