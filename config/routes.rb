Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'events#index'

  resources :event_attendings
  resources :users
  resources :events
  resources :events do
    post :toggle_attendee
    post :add_attendee
    post :remove_attendee
  end
end
