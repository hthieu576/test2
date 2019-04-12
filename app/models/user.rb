# frozen_string_literal: true

class User < ApplicationRecord
  has_many :orders, dependent: :restrict_with_exception
end
