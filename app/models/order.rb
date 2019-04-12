# frozen_string_literal: true

class Order < ApplicationRecord
  # TODO: In this case, I just use has_one relation for easy to implement.
  has_one :payment, inverse_of: :order, dependent: :restrict_with_exception
  has_many :products, inverse_of: :order, dependent: :restrict_with_exception
  belongs_to :user
end
