class OrdersSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :status, :comment, :products

  has_many :products, serializer: ProductSerializer
end
