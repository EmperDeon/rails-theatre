Rails.application.routes.draw do
  root 'index#index'

  resources :articles, only: [:index, :show]
  resources :theatres, only: [:index, :show]

  get 'posters', to: 'posters#index'
  get 'posters/:id', to: 't_performances#show'

  get 'performances', to: 't_performances#index'
  get 'performances/:id', to: 't_performances#show'
end
