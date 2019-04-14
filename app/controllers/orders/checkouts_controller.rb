# frozen_string_literal: true

class Orders::CheckoutsController < ActionController::Base
  before_action :set_order, :set_promotional_rules, only: %i[create]

  def create
    ::Checkouts::CreateService.call(@order, @promotional_rules).result
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
    authorize @order, :order_owner?
  end

  def set_promotional_rules
    @promotional_rules = Promotion.new.rules
  end
end
