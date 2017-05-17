Rails.application.routes.draw do
	devise_for :users, controllers: {registrations: 'auth/register'}

	resources :articles, only: [:index, :show]
	resources :actors, only: [:index, :show]
	resources :theatres, only: [:index, :show]

	get 'posters', to: 'posters#index'
	get 'posters/:id', to: 't_performances#show'

	get 'performances', to: 't_performances#index'
	get 'performances/:id', to: 't_performances#show'

	get 'favorites', to: 'favorites#index'
	get 'favorites/add/:id', to: 'favorites#add_to_favorites'
	get 'favorites/del/:id', to: 'favorites#del_from_favorites'

	get 'tickets/buy_form/:id', to: 'tickets#buy_form'
	get 'tickets/buy/:id/:seat', to: 'tickets#buy'

	get 'utils/hall_preview/:id/:poster', to: 'utils#get_hall_preview'

	root 'index#index'
end
