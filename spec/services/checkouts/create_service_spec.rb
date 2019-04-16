# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Checkouts::CreateService do
  describe '.initialize' do
    subject { described_class.new(order) }

    let(:order) { create(:order) }

    it { is_expected.to be_a described_class }
  end

  describe '#call' do
    subject do
      described_class.call(order).result
    end

    let(:order) { create(:order) }

    context 'when empty product' do
      it 'has error' do
        expect { subject }.to raise_error('Product was not found')
      end
    end

    context 'when order already checked' do
      let!(:products) { create_list(:product, 2, order_id: order.id) }
      let!(:checkout) { create(:checkout, order_id: order.id) }

      it 'has error' do
        expect { subject }.to raise_error('Order has already checked')
      end
    end

    context 'when nominal case' do
      let!(:products) { create_list(:product, 2, order_id: order.id) }

      it { expect { subject }.to change { Checkout.count }.from(0).to(1) }
    end
  end
end
