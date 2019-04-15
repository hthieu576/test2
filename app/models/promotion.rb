# frozen_string_literal: true

class Promotion < ApplicationRecord
  def rules # rubocop:disable Metrics/MethodLength
    {
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
    }
  end
end
