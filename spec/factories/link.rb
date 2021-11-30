require 'ffaker'

FactoryBot.define do
  factory :link do
    url { FFaker::Internet.http_url}
    with_user

    trait :with_user do
      user
    end
  end
end
