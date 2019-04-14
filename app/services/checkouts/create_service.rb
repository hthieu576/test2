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
                            total_amount: total_amount_promoted,
                            status: 'confirmed')
  end

  def products_scanned!
    @products.each_with_object([]) do |product, array|
      array << scan_item(product)
    end.uniq
  end

  def scan_item(product)
    ProductSerializer.new(product).as_json
                     .merge(quantity: quantity(product))
  end

  def promotions?(product)
    quantity_eligible?(product) || total_amount_eligible?
  end

  def quantity(product)
    @products.map(&:code).count(product.code)
  end

  def total_amount_promoted
    @products.map(&:price).sum
  end

  def quantity_eligible?(product)
    quantity(product) >= @promotional_rules[:products]['001'][:min_quantity]
  end

  def total_amount_eligible?
    @order.total_amount >= @promotional_rules[:total][:min_amount]
  end
end
