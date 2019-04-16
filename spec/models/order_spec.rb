# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  status     :string           not null
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#initialize' do
    subject { described_class.new }

    it { is_expected.to be_a described_class }
  end

  describe '#total_amount' do
    subject { order.total_amount }

    let(:order) { create(:order) }
    let!(:products) { create_list(:product, 2, order_id: order.id, price: 10) }

    it { is_expected.to eq(20) }
  end

  describe '#quantity_product(code)' do
    subject { order.quantity_product('001') }

    let(:order) { create(:order) }
    let!(:products) { create_list(:product, 2, order_id: order.id, code: '001') }

    it { is_expected.to eq(2) }
  end

  describe '#total_amount_eligible?' do
    subject { order.total_amount_eligible? }

    let(:order) { create(:order) }

    context 'when total_amount less than min_amount eligible' do
      let!(:products) do
        create_list(:product, 2, order_id: order.id, price: 10)
      end

      it { is_expected.to eq false }
    end

    context 'when total_amount greater than or equal min_amount eligible' do
      let!(:products) do
        create_list(:product, 2, order_id: order.id, price: 50)
      end

      it { is_expected.to eq true }
    end
  end

  describe '#quantity_eligible?(code)' do
    subject { order.quantity_eligible?('001') }

    let(:order) { create(:order) }

    context 'when quantity less than min_quantity eligible' do
      let!(:products) do
        create_list(:product, 2, order_id: order.id, code: '002')
        create(:product, order_id: order.id, code: '001')
      end

      it { is_expected.to eq false }
    end

    context 'when quantity greater than or equal min_quantity eligible' do
      let!(:products) do
        create_list(:product, 2, order_id: order.id, code: '001')
        create(:product, order_id: order.id, code: '002')
      end

      it { is_expected.to eq true }
    end
  end
end
