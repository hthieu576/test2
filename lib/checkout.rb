# frozen_string_literal: true

require File.expand_path('../config/environment', __dir__)
require_relative 'promotion'
require_relative '../app/models/product.rb'
require_relative '../app/models/order.rb'

class Checkout
  DATA_MAPPING = {
    order: Order,
    product: Product
    # ....
  }.freeze

  def initialize(order_id, promotion)
    @order_id = order_id
    @promotional_rules = Promotion.new(promotion).rules if promotion
  end

  def call
    validate!
    { basket: products.pluck(:code).join(', '), total_price_expected: "£#{total_price_expected.round(2)}" }
  end

  private

  attr_reader :promotional_rules
  attr_accessor :obj

  def validate!
    raise 'Product can not be found' if products.blank?
  end

  def order
    self.obj = :order
    data_instance.find @order_id
  end

  def products
    order.products
  end

  # Scan products to check quantity.
  def products_scanned
    products.each_with_object([]) do |product, result|
      result << { code: product[:code], price: product[:price], quantity: order.quantity_product(product[:code]) }
    end.uniq
  end

  def total_price_expected
    amount = products_scanned.each_with_object([]) do |product, result|
      result << calculating_price!(product)
    end.sum
    order.total_amount_eligible? ? apply_discount(amount) : amount
  end

  def calculating_price!(product)
    if order.quantity_eligible?(product[:code])
      promotional_rules[:products]['001'][:price_discount] * product[:quantity]
    else
      product[:price] * product[:quantity]
    end
  end

  def apply_discount(amount)
    amount - (promotional_rules[:total][:discount_percent].to_f / 100 * amount)
  end

  def data_instance
    @data_instance ||= DATA_MAPPING[obj]
  end
end
