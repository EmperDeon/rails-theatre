Rails.application.routes.draw do
  get 'articles/index', to: 'article#index'
  get 'articles/:id', to: 'article#show'

  get 'posters', to: 'poster#index'
  get 'posters/:id', to: 't_performance#show'

  get 'performances', to: 't_performance#index'
  get 'performances/:id', to: 't_performance#show'

  get 'theatres', to: 'theatre#index'
  get 'theatres/:id', to: 'theatre#show'

  root 'index#index'
end
