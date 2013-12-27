require 'faker'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
    subdivision_id "1"
  end
end
