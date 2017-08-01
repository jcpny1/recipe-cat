Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations', sessions: 'users/sessions' }

  resources :ingredients, only: [:index, :show]
  get '/ingredients/updated_after/:date', to: "ingredients#updated_after"

  resources :recipes do
    resources :recipe_ingredients, only: [:index]
    resources :recipe_steps,       only: [:index]
    resources :recipe_reviews
    collection { post 'filter' }
  end
  get  '/recipes/updated_after/:date',        to: "recipes#updated_after"
  get  '/recipe_reviews/updated_after/:date', to: "recipe_reviews#updated_after"

  resources :users do
    resources :recipes,               only: [:index]
    resources :recipe_reviews,        only: [:index]
    resources :user_recipe_favorites, only: [:index, :update]
  end

  get  '/recent_edits', to: "application#recent_edits_select"
  post '/recent_edits', to: "application#recent_edits"
  get  '/about',        to: "application#about"
  root "application#welcome"
end
