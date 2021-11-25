require 'ffaker'

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
  end
end