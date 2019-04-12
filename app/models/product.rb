# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :order, inverse_of: :products
end
