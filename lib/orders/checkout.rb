# frozen_string_literal: true

require 'orders/promotion'

module Orders
  class Checkout
    include ::Orders::Promotion

    def initialize(promotional_rules); end
  end
end
