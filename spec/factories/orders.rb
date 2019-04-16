# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  status     :string           not null
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :order do
    association :user
    status { 'ordered' }
    comment { Faker::Lorem.word }
  end
end
