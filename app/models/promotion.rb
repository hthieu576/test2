class Promotion < ApplicationRecord
  def rules # rubocop:disable Metrics/MethodLength
    {
      total: {
        min_amount: 60,
        discount_precent: 10,
      },
      products: {
        '001' => {
          min_quantity: 2,
          promo_price: 8.5
        }
      }
    }
  end
end
