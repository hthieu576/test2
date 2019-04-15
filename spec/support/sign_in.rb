# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_context 'Sign in', :sign_in do
  let(:user) { create(:user) }

  # TODO: temporary for user signed in.
  before do
    user
  end
end

RSpec.shared_context 'Sign out', :sign_out do
  before do
    sign_out user
  end
end

RSpec.configure do |config|
  config.include_context 'Sign in', :sign_in
  config.include_context 'Sign out', :sign_out
end
