Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :recipes do
#    resources :recipe_ingredients
    resources :user_recipe_reviews, only: [:index]
  end

  resources :users do
    resources :recipes,               only: [:index]
    resources :user_recipe_favorites, only: [:index]
    resources :user_recipe_reviews,   only: [:index]
  end

  resources :user_recipe_reviews, only: [:index, :show]
  resources :ingredients,         only: [:index, :show]

  get '/about', to: "application#about"

  root "application#welcome"
end
