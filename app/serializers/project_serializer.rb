# frozen_string_literal: true

# class
class ProjectSerializer
  include JSONAPI::Serializer
  has_many :candidates
  attributes :name, :description, :bill
end
