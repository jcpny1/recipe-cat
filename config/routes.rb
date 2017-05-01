Rails.application.routes.draw do
  get 'recipe_ingredients/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :recipes do
    resources :user_recipe_reviews, only: [:index]
    resources :recipe_ingredients,  only: [:index, :new, :create, :destroy]
    resources :recipe_steps,        only: [:index, :new, :create, :destroy]
  end
  post '/recipe_ingredients/filter', to: 'recipe_ingredients#filter'

  resources :users do
    resources :recipes,               only: [:index]
    resources :user_recipe_favorites, only: [:index, :update]
    resources :user_recipe_reviews,   only: [:index]
  end

  resources :user_recipe_reviews, only: [:index, :show]
  resources :ingredients,         only: [:index, :show]

  get '/about', to: "application#about"

  root "application#welcome"
end
