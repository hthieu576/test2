# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders, only: [] do
    resources :checkouts, controller: 'orders/checkouts', only: %i[create]
    resource :thanks, controller: 'orders/thanks', only: %i[show]
  end
end
