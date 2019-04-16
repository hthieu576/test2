# frozen_string_literal: true

# == Schema Information
#
# Table name: checkouts
#
#  id           :integer          not null, primary key
#  order_id     :integer          not null
#  method_type  :string           not null
#  total_amount :decimal(10, 2)   not null
#  status       :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Checkout, type: :model do
  describe '#initialize' do
    subject { described_class.new }

    it { is_expected.to be_a described_class }
  end

  describe '#scan_item(product)' do
    subject { checkout.scan_item(product) }

    let(:checkout) { Checkout.new }
    let(:order) { create(:order) }
    let!(:product) { create(:product, order_id: order.id, code: '003') }

    it { is_expected.to eq(code: '003', price: 10) }
  end
end
