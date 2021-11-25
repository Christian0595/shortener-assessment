require 'ffaker'

FactoryBot.define do
  factory :link do
    user
    url { FFaker::Internet.http_url}
  end
end
