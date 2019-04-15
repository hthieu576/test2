# frozen_string_literal: true

class Order < ApplicationRecord
  has_one :checkout, inverse_of: :order, dependent: :restrict_with_exception
  has_many :products, inverse_of: :order, dependent: :restrict_with_exception
  belongs_to :user

  def total_amount
    products.map(&:price).sum
  end

  def quantity_product(product_code)
    products.map(&:code).count(product_code)
  end
end
