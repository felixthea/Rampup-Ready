# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :definition do
    word_id 1
    user_id 1
    body Faker::Lorem.sentences
    subdivision_id 1
  end
end
