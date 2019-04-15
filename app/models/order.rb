# frozen_string_literal: true

class Order < ApplicationRecord
  include PromotionConcern

  has_one :checkout, inverse_of: :order, dependent: :restrict_with_exception
  has_many :products, inverse_of: :order, dependent: :restrict_with_exception
  belongs_to :user

  def total_amount
    products.map(&:price).sum
  end

  def total_amount_eligible?
    total_amount >= rules[:total][:min_amount]
  end

  def quantity_eligible?(product_code)
    quantity_product(product_code) >= rules[:products]['001'][:min_quantity]
  end

  def quantity_product(product_code)
    products.map(&:code).count(product_code)
  end
end
