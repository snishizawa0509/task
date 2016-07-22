Rails.application.routes.draw do
  resources :categories , only: [:edit, :update, :index, :create, :destroy]
  resources :notes

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'home#top'
end

