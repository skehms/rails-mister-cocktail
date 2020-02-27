Rails.application.routes.draw do
  resources :cocktails, only: [:index, :show, :create, :new] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]
  root to: 'coktail#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

