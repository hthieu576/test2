# frozen_string_literal: true

class Promotion
  attr_reader :rules

  RULES = {
    total: {
      min_amount: 60,
      discount_percent: 10
    },
    products: {
      '001' => {
        min_quantity: 2,
        price_discount: 8.5
      }
    }
  }.freeze

  def initialize(rules=nil)
    @rules = rules
  end
end
