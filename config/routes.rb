Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'events#index'

  get 'events/:id/edit', to: 'events#edit', as: :edit_event
  patch 'events/:id', to: 'events#update'

  resources :event_attendings
  resources :users
  resources :events do
    post :add_attendee
    post :remove_attendee
    get :attended
  end
end
