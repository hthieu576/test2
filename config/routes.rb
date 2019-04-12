# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, only: [] do
    resources :checkouts, controller: 'orders/checkouts', only: %i[create]
    resource :thanks, controller: 'orders/thanks', only: %i[show]
  end
end
