# encoding: utf-8
class Session < ActiveModelBase
  
  attr_accessor :identification, :password, :remember_me

  validates :identification, :password, presence: true
  
end