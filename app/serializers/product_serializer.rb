# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :code, :price
end
