class Checkout < ApplicationRecord
  belongs_to :order, inverse_of: :checkout
end
