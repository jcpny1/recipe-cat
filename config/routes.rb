Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :ingredients

  resources :recipes do
    resources :recipe_ingredients
  end

  root "application#welcome"
end
