# frozen_string_literal: true

# class
class Candidate < ApplicationRecord
  belongs_to :user

  has_many :candidates_projects

  has_and_belongs_to_many :projects, through: 'candidates_projects'

  validates :name,
            presence: true

  validates :email,
            presence: true
end
