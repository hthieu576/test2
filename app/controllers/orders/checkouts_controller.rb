# frozen_string_literal: true

class Orders::CheckoutsController < ActionController::Base
  before_action :set_order, only: %i[show]

  def show; end

  private

  def set_order
    @order = Order.find(params[:order_id])
    authorize @order, :order_owner?
  end
end
