# frozen_string_literal: true

class Checkout < ApplicationRecord
  include PromotionConcern

  belongs_to :order, inverse_of: :checkout

  enum status: { failed: 'failed', confirmed: 'confirmed' }
  enum method_type: { creditcard: 'creditcard', paypal: 'paypal' }

  def scan_item(product)
    ProductSerializer.new(product).as_json
  end
end
