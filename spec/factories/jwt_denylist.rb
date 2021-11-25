require 'ffaker'

FactoryBot.define do
  factory :jwt_denylist do
    jti { FFaker::Lorem.characters(10)}
    expired_at { FFaker::Time.between(Date.today - 1, Date.today - 15)}
  end
end