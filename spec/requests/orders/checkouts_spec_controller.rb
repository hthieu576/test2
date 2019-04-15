# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders::CheckoutsController', type: :request do
  include_context 'Sign in'

  describe 'POST /orders/:order_id/checkouts' do
    subject do
      post order_checkouts_path(order.id)
    end

    let(:order) { create(:order, user_id: user.id) }

    context 'when nominal case' do
      let!(:products) { create_list(:product, 2, order_id: order.id) }

      it 'redirect' do
        expect(subject).to redirect_to order_thanks_path(order)
      end

      it 'status' do
        subject
        expect(subject).to eq(302)
      end
    end

    context 'when empty product' do
      it 'has error' do
        expect { subject }.to raise_error('Products not found')
      end
    end

    context 'when order already checked' do
      let!(:products) { create_list(:product, 2, order_id: order.id) }
      let!(:checkout) { create(:checkout, order_id: order.id) }

      it 'has error' do
        expect { subject }.to raise_error('Order already checked')
      end
    end

    context 'when order not found' do
      subject do
        post order_checkouts_path(9999)
      end
      it 'raise exception' do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
