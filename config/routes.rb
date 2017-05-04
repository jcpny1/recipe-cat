Rails.application.routes.draw do
  get 'recipe_ingredients/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :recipes do
    resources :recipe_reviews, only: [:index]
    resources :recipe_ingredients,  only: [:new, :create, :edit, :update, :destroy]
    resources :recipe_steps,        only: [:new, :create, :edit, :update, :destroy]
    collection { post 'filter' }
    get 'renumber_steps', on: :member
  end

  resources :users do
    resources :recipes,               only: [:index]
    resources :user_recipe_favorites, only: [:index, :update]
    resources :recipe_reviews,        only: [:index, :new, :create, :edit, :update, :destroy]
  end

#  resources :recipe_reviews, only: [:index, :show]
  resources :ingredients,    only: [:index, :show]

  get '/about', to: "application#about"

  root "application#welcome"
end
