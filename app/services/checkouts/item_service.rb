# frozen_string_literal: true

class Checkouts::ItemService < Patterns::Service
  def initialize(order)
    @order = order
  end

  def call; end
end
