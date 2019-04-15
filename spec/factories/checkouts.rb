# frozen_string_literal: true

FactoryBot.define do
  factory :checkout do
    association :order
    method_type { %w[creditcard paypal].sample }
    status { 'confirmed' }
    total_amount { 1000 }
  end
end
