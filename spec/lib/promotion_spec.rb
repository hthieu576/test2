# frozen_string_literal: true

require 'rails_helper'
require 'promotion'

RSpec.describe Promotion do
  describe '.initialize' do
    subject { described_class.new(rules) }

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
end
