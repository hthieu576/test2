# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user
    status { 'ordered' }
    text { Faker::Lorem.word }
  end
end
