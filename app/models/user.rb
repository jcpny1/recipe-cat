class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_one  :address
  accepts_nested_attributes_for :address

  has_many :recipes,               dependent: :destroy
  has_many :recipe_reviews,        dependent: :destroy
  has_many :user_recipe_favorites, dependent: :destroy

  enum role: [:user, :vip, :admin]

  after_initialize do |user|
    user.address ||= Address.new
  end

  def name
    self.email
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

end
