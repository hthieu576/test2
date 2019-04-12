# frozen_string_literal: true

class Checkouts::ItemFromOrderService < Patterns::Service
  class Error < StandardError; end

  def initialize(order, promotional_rules)
    @order = order
    @order_products = @order.products
    @promotional_rules = promotional_rules
  end

  def call
    raise Error, 'Items not found' if @order_items.blank?
    # creating_checkout!
  end

  private

  def creating_checkout!
    @order.create_checkout!(method_type: 'creditcard',
                            total_amount: 100,
                            status: 'confirmed')
  end

  def incentive?
    @order_products.map(&:code).count('001') >= @promotional_rules[:products]['001'][:min_quantity]
  end
end
