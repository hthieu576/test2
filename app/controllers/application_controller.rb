# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    render file: Rails.root.join('public', '404'), layout: false, status: :not_found
  end
end
