# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :name do |n| 
      "user_name#{n}"
    end
    sequence :email do |n| 
      "#email_{n}@domain.local"
    end
    
    password "a" * 8
    password_confirmation "a" * 8
  end
end
