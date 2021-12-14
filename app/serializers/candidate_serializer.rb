# frozen_string_literal: true

# class
class CandidateSerializer
  include JSONAPI::Serializer
  has_many :projects
  attributes :name, :email
end
