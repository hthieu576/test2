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
        expect { subject }.to raise_error('Product can not be found')
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
      context 'with case basket: 001,002,003' do
        let!(:products) do
          create(:product, order_id: order.id, code: '001', price: 9.25)
          create(:product, order_id: order.id, code: '002', price: 45.00)
          create(:product, order_id: order.id, code: '003', price: 19.95)
        end

        it 'total_amount' do
          expect(subject.total_amount).to eq 66.78
        end

        it { expect { subject }.to change { Checkout.count }.from(0).to(1) }
      end

      context 'with case basket: 001,003,001' do
        let!(:products) do
          create_list(:product, 2, order_id: order.id, code: '001', price: 9.25)
          create(:product, order_id: order.id, code: '003', price: 19.95)
        end

        it 'total_amount' do
          expect(subject.total_amount).to eq 36.95
        end

        it { expect { subject }.to change { Checkout.count }.from(0).to(1) }
      end

      context 'with case basket: 001,002,001,003' do
        let!(:products) do
          create_list(:product, 2, order_id: order.id, code: '001', price: 9.25)
          create(:product, order_id: order.id, code: '002', price: 45.00)
          create(:product, order_id: order.id, code: '003', price: 19.95)
        end

        it 'total_amount' do
          expect(subject.total_amount).to be_within(0.1).of(73.76)
        end

        it { expect { subject }.to change { Checkout.count }.from(0).to(1) }
      end

      context 'with has not promotion case' do
        let!(:products) do
          create(:product, order_id: order.id, code: '001', price: 9.25)
          create(:product, order_id: order.id, code: '003', price: 19.95)
        end

        it 'total_amount' do
          expect(subject.total_amount).to eq 29.2
        end

        it { expect { subject }.to change { Checkout.count }.from(0).to(1) }
      end
    end
  end
end
