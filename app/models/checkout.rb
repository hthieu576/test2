# frozen_string_literal: true

# == Schema Information
#
# Table name: checkouts
#
#  id           :integer          not null, primary key
#  order_id     :integer          not null
#  method_type  :string           not null
#  total_amount :decimal(10, 2)   not null
#  status       :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Checkout < ApplicationRecord
  include PromotionConcern

  belongs_to :order, inverse_of: :checkout

  enum status: { failed: 'failed', confirmed: 'confirmed' }
  enum method_type: { creditcard: 'creditcard', paypal: 'paypal' }
end
