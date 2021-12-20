# frozen_string_literal: true

# class
class Candidate < ApplicationRecord
  belongs_to :user

  has_many :candidates_projects
  has_and_belongs_to_many :projects

  before_destroy do
    projects.each { |project| project.destroy }
    #projects(&:destroy) 
  end

  validates_presence_of :name
  validates_presence_of :email
end
