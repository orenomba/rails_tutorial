# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    identification "test"
    password "pass"
    remember_me false
  end
end
