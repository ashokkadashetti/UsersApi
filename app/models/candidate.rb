# frozen_string_literal: true

# class
class Candidate < ApplicationRecord
  belongs_to :user

  has_many :candidates_projects

  has_and_belongs_to_many :projects, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :email

end
