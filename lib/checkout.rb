# frozen_string_literal: true

require File.expand_path('../../config/environment',  __FILE__)
require_relative 'promotion'
require_relative '../app/models/product.rb'
require_relative '../app/models/order.rb'

class Checkout
  DATA_MAPPING = {
    order: Order,
    product: Product,
  }.freeze

  def initialize(rules=nil)
    @products = []
    @promotional_rules = Promotion.new(rules) if rules
  end

  def product
    self.obj = :product
    data_instance.all
  end

  def scan(product)
    product_scanned = find_product_by(product[:code])
    if product_scanned.present?
      product_scanned[:quantity] += 1
    else
      @products << { data: product, quantity: 1 }
    end
  end

  private

  def find_product_by(code)
    @products.detect { |product| product[:data][:code] == code }
  end

  attr_accessor :obj

  def data_instance
    @data_instance ||= DATA_MAPPING[obj]
  end
end
