Rails.application.routes.draw do
  get 'recipe_ingredients/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  resources :ingredients, only: [:index, :show]

  resources :recipes do
    resources :recipe_ingredients, only: [:new, :create, :edit, :update, :destroy]
    resources :recipe_reviews,     only: [:index, :new, :create, :edit, :update, :destroy]
    resources :recipe_steps,       only: [:new, :create, :edit, :update, :destroy]
    collection { post 'filter' }
    get 'renumber_steps', on: :member
  end

  resources :users do
    resources :recipes,               only: [:index]
    resources :recipe_reviews,        only: [:index]
    resources :user_recipe_favorites, only: [:index, :update]
  end

  get  '/recent_edits', to: 'application#recent_edits_select'
  post '/recent_edits', to: 'application#recent_edits'

  get '/ingredients/updated_after/:date',    to: 'ingredients#updated_after'
  get '/recipes/updated_after/:date',        to: 'recipes#updated_after'
  get '/recipe_reviews/updated_after/:date', to: 'recipe_reviews#updated_after'

  get '/about', to: 'application#about'
  root 'application#welcome'
end
