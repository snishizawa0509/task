Rails.application.routes.draw do
  get 'notes/new' => 'notes#new'
  post 'notes/create' => 'notes#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'home#top'
end

