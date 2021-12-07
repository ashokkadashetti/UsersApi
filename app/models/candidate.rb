# frozen_string_literal: true

# class
class Candidate < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :projects

  validates :name,
            presence: true,
            uniqueness: true

  validates :email,
            presence: true,
            uniqueness: true
end
