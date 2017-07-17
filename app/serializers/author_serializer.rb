class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :recipes
end
