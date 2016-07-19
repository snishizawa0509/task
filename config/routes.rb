Rails.application.routes.draw do
  get 'notes/new' => 'notes#new'
  post 'notes/create' => 'notes#create'
  get '/notes' => 'notes#index'
  get '/notes/:id' => 'notes#show', as:'note'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'home#top'
end

