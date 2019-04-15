# frozen_string_literal: true

class Checkouts::CreateService < Patterns::Service
  class Error < StandardError; end

  def initialize(order, promotional_rules)
    @order = order
    @products = @order.products
    @promotional_rules = promotional_rules
  end

  def call
    validate!
    ApplicationRecord.transaction do
      creating_checkout!
    end
  end

  private

  def validate!
    raise Error, 'Products not found' if @products.blank?
    raise Error, 'Order already exists' if @order.checkout.present?
  end

  def creating_checkout!
    @order.create_checkout!(method_type: 'creditcard',
                            total_amount: total_amount,
                            status: 'confirmed')
  end

  def products_scanned
    @products.each_with_object([]) do |product, result|
      result << scan_item(product)
    end.uniq
  end

  def scan_item(product)
    ProductSerializer.new(product).as_json
                     .merge(quantity: quantity_product(product.code))
  end

  def quantity_product(product_code)
    @products.map(&:code).count(product_code)
  end

  def total_amount
    total_amount = products_scanned.each_with_object([]) do |product, result|
      result << calculating_price!(product)
    end.sum
    total_amount_eligible? ? apply_discount(total_amount) : total_amount
  end

  def quantity_eligible?(product_code)
    quantity_product(product_code) >= @promotional_rules[:products]['001'][:min_quantity]
  end

  def total_amount_eligible?
    @order.total_amount >= @promotional_rules[:total][:min_amount]
  end

  def calculating_price!(product)
    if quantity_eligible?(product[:code])
      @promotional_rules[:products]['001'][:price_discount] * product[:quantity]
    else
      product[:price] * product[:quantity]
    end
  end

  def apply_discount(amount)
    amount - (@promotional_rules[:total][:discount_percent].to_f / 100 * amount)
  end
end
