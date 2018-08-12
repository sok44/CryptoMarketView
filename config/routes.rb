Rails.application.routes.draw do

  root 'pages#index'

  resources :markets
  
  resources :currencies do
    resources :currency_pairs
  end

  resources :currency_pairs
  resources :market_currency_pair_names

  resources :market_symbol_precisions
  
  resources :period_quotation_types
  resources :market_period_names

  resources :quotations

  resource :load_data, only: [:new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
