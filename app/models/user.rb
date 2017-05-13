# a registered user of recipe cat.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_one  :address
  accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true

  has_many :recipes,               dependent: :destroy
  has_many :recipe_reviews,        dependent: :destroy
  has_many :user_recipe_favorites, dependent: :destroy

  # user authorization levels.
  enum role: [:user, :vip, :admin]

  # do not allow user's address to be null.
  after_initialize do |user|
    user.address ||= Address.new
  end

  # returns the name of this user. (currently the user's email address)
  def name
    self.email
  end

  # This method finds an existing user by the provider and uid fields.
  # If no user is found, a new one is created with a random password.
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
