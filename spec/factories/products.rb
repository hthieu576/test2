# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    association :order
    code { %w[001 002 003].sample }
    name { ['Lavender heart', 'Personalised cufflinks'].sample }
    price { 10 }
  end
end
