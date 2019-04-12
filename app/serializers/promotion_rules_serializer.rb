class PromotionRulesSerializer < ActiveModel::Serializer
  attributes :rules

  def rules
    {
      total: {
        min_amount: 60,
        discount: 10,
        discount_type: 'precent',
      },
      items: {
        '001' => {
          min_quantity: 2,
          discount_type: 'price',
          promo_price: 8.5,
        }
      }
    }
  end
end
