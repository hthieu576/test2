# frozen_string_literal: true

class Promotion
  attr_reader :rules
  # RULES = {
  #   total: {
  #     min_amount: 60,
  #     discount_percent: 10
  #   },
  #   products: {
  #     '001' => {
  #       min_quantity: 2,
  #       price_discount: 8.5
  #     }
  #   }
  # }.freeze

  # def total_amount
  #   products.map(&:price).sum
  # end

  # def quantity_product(product_code)
  #   products.map(&:code).count(product_code)
  # end

  # def total_amount_eligible?
  #   total_amount >= rules[:total][:min_amount]
  # end

  # def quantity_eligible?(product_code)
  #   quantity_product(product_code) >= rules[:products]['001'][:min_quantity]
  # end

  def initialize(rules)
    @rules = rules
  end
end
