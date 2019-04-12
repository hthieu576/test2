# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :order_id, :user_id, :status, :comment, :products

  has_many :products, serializer: ProductSerializer

  def order_id
    object.id
  end
end
