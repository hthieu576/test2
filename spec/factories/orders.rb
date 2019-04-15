# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user
    status { 'ordered' }
    comment { Faker::Lorem.word }
  end
end
