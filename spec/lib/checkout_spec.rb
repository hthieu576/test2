# frozen_string_literal: true

require 'rails_helper'
require 'checkout'

RSpec.describe Checkout do
  describe '.initialize' do
    subject { described_class.new(order.id, rules) }

    let(:order) { create(:order) }
    let(:rules) do
      {
        total: {
          min_amount: 60,
          discount_percent: 10
        },
        products: {
          '001' => {
            min_quantity: 2,
            price_discount: 8.5
          }
        }
      }.freeze
    end

    it { is_expected.to be_a described_class }
  end

  describe '#call' do
    subject do
      described_class.new(order.id, rules).call
    end

    let(:order) { create(:order) }
    let(:rules) do
      {
        total: {
          min_amount: 60,
          discount_percent: 10
        },
        products: {
          '001' => {
            min_quantity: 2,
            price_discount: 8.5
          }
        }
      }.freeze
    end

    context 'when empty product' do
      it 'has error' do
        expect { subject }.to raise_error('Product can not be found')
      end
    end

    context 'when nominal case' do
      context 'with case basket: 001,002,003' do
        let!(:products) do
          create(:product, order_id: order.id, code: '001', price: 9.25)
          create(:product, order_id: order.id, code: '002', price: 45.00)
          create(:product, order_id: order.id, code: '003', price: 19.95)
        end

        it 'total_price_expected' do
          expect(subject).to eq({ basket: '001, 002, 003', total_price_expected: '£66.78' })
        end
      end

      context 'with case basket: 001,003,001' do
        let!(:products) do
          create_list(:product, 2, order_id: order.id, code: '001', price: 9.25)
          create(:product, order_id: order.id, code: '003', price: 19.95)
        end

        it 'total_price_expected' do
          expect(subject).to eq({ basket: '001, 001, 003', total_price_expected: '£36.95'})
        end
      end

      context 'with case basket: 001,002,001,003' do
        let!(:products) do
          create_list(:product, 2, order_id: order.id, code: '001', price: 9.25)
          create(:product, order_id: order.id, code: '002', price: 45.00)
          create(:product, order_id: order.id, code: '003', price: 19.95)
        end

        it 'total_price_expected' do
          expect(subject).to eq ({ basket: '001, 001, 002, 003', total_price_expected: '£73.76' })
        end
      end

      context 'with has not promotion case' do
        let!(:products) do
          create(:product, order_id: order.id, code: '001', price: 9.25)
          create(:product, order_id: order.id, code: '003', price: 19.95)
        end

        it 'total_price_expected' do
          expect(subject).to eq({ basket: '001, 003', total_price_expected: '£29.2' })
        end
      end
    end
  end
end
