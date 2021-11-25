require 'ffaker'

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    valid
    
    trait :valid do
      password { FFaker::Internet.password }
    end

    trait :invalid do
      password { nil }
    end  
  end
end