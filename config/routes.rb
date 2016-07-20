Rails.application.routes.draw do
  get 'notes/new' => 'notes#new'
  post 'notes/create' => 'notes#create'
  get '/notes' => 'notes#index'
  get '/notes/:id' => 'notes#show', as:'note'
	patch '/notes/:id' => 'notes#update', as:'note_update'
  get '/notes/:id/edit' => 'notes#edit', as:'note_edit'
	delete '/notes:id' => 'notes#destroy', as:'note_destroy'
  get '/category' => 'categories#new', as:'category'
  post '/category' => 'categories#create', as:'category_create'
  delete '/category:id' => 'categories#destroy', as:'category_destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'home#top'
end

