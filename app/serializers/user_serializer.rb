# frozen_string_literal: true

# class
class UserSerializer
  include JSONAPI::Serializer
  has_many :candidates
  attributes :name, :email, :role
end
