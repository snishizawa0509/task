Rails.application.routes.draw do
  get 'notes/new' => 'notes#new'
  post 'notes/create' => 'notes#create'
  get '/notes' => 'notes#index'
  get '/notes/:id' => 'notes#show', as:'note'
	patch '/notes/:id' => 'notes#update', as:'note_update'
  get '/notes/:id/edit' => 'notes#edit', as:'note_edit'
	delete '/notes:id' => 'notes#destroy', as:'note_destroy'
  get '/category' => 'category#new', as:'category'
  post '/category' => 'category#create', as:'category_create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root 'home#top'
end

