# frozen_string_literal: true

class Checkouts::CreateService < Patterns::Service
  class Error < StandardError; end

  def initialize(order)
    @order = order
    @products = @order.products
    @checkout = Checkout.new
  end

  def call
    validate!
    ApplicationRecord.transaction do
      creating_checkout!
    end
  end

  private

  def validate!
    raise Error, 'Product can not be found' if @products.blank?
    raise Error, 'Order has already checked' if @order.checkout.present?
  end

  def creating_checkout!
    @order.create_checkout!(method_type: :creditcard,
                            total_amount: total_amount,
                            status: :confirmed)
  end

  # Scan products to check quantity.
  def products_scanned
    @products.each_with_object([]) do |product, result|
      result << @checkout.scan_item(product)
                         .merge(quantity: @order.quantity_product(product.code))
    end.uniq
  end

  def total_amount
    amount = products_scanned.each_with_object([]) do |product, result|
      result << calculating_price!(product)
    end.sum
    @order.total_amount_eligible? ? apply_discount(amount) : amount
  end

  def calculating_price!(product)
    if @order.quantity_eligible?(product[:code])
      @checkout.rules[:products]['001'][:price_discount] * product[:quantity]
    else
      product[:price] * product[:quantity]
    end
  end

  def apply_discount(amount)
    amount - (@checkout.rules[:total][:discount_percent].to_f / 100 * amount)
  end
end
