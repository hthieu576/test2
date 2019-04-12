# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :order_id, :user_id, :status, :comment, :products, :promotion

  has_many :products, serializer: ProductSerializer

  def order_id
    object.id
  end

  def promotion
    PromotionRuleSerializer.new(object).as_json
  end
end
