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
  pending "add some examples to (or delete) #{__FILE__}"
end
