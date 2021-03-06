# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  order_id   :integer          not null
#  code       :string           not null
#  name       :string           not null
#  price      :decimal(10, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :product do
    association :order
    code { %w[001 002 003].sample }
    name { ['Lavender heart', 'Personalised cufflinks'].sample }
    price { 10 }
  end
end
