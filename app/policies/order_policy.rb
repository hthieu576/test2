# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  attr_reader :user, :order

  def initialize(context, order)
    @user = context.user
    @order = order
  end

  def order_owner?
    @user.id == @order.user_id
  end
end
