Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bank_accounts, only: %i[index create]
  resources :money_transfers, only: :create
  root 'bank_accounts#index'
end
