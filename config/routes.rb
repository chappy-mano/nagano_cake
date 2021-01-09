Rails.application.routes.draw do

  # customer
  root 'public/homes#top'
  get '/about' => 'public/homes#about'

  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
  }

  resource :customers

  # resources :items
  get '/items' => 'public/items#index'
  get '/item/:id' => 'public/items#show', as:'item'


  # admin
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }

  namespace :admin do
    resources :items, :customers
  end
   namespace :admin do
    resources :genres, only:[:index, :create, :edit, :update]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
