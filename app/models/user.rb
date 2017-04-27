class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :recipes
  has_many :user_ingredients
  has_many :ingredients, through: :user_ingredients
  has_many :user_recipe_reviews
  has_many :user_recipe_favorites

  enum role: [:user, :vip, :admin]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
