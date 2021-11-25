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

    factory :user_with_links do
      # links_count is declared as a transient attribute available in the
      # callback via the evaluator
      transient do
        links_count { 10 }
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        create_list(:link, evaluator.links_count, user: user)
        
        user.reload
      end
    end
  end
end
