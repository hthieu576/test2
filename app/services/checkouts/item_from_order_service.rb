# frozen_string_literal: true

class Checkouts::ItemFromOrderService < Patterns::Service
  class Error < StandardError; end

  def initialize(order, promotional_rules)
    @order = order
    @products = @order.products
    @promotional_rules = promotional_rules
    @products_scanned = []
  end

  def call
    raise Error, 'Products not found' if @products.blank?
    creating_checkout!
  end

  private

  def creating_checkout!
    @order.create_checkout!(method_type: 'creditcard',
                            total_amount: 100,
                            status: 'confirmed')
  end

  def validating_products!
    @products.each do |product|
      # will check scan method later.
      @products_scanned << scan_item(product)
    end
    @products_scanned.uniq!
  end

  def scan_item(product)
    ProductSerializer.new(product).as_json
                     .merge(quantity: quantity(product))
  end

  def incentive?(product)
    quantity(product) >= @promotional_rules[:products]['001'][:min_quantity]
  end

  def quantity(product)
    @products.map(&:code).count(product.code)
  end
end
