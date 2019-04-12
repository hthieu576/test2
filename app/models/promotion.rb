class Promotion < ApplicationRecord
  def rules # rubocop:disable Metrics/MethodLength
    {
      total: {
        min_amount: 60,
        discount: 10,
        discount_type: 'precent'
      },
      products: {
        '001' => {
          min_quantity: 2,
          discount_type: 'price',
          promo_price: 8.5
        }
      }
    }
  end
end
