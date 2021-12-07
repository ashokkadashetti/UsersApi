# frozen_string_literal: true

# class
class Project < ApplicationRecord
  has_and_belongs_to_many :candidates

  validates :name, presence: true
  validates :description, presence: true
  validates :idle, presence: true
  validates :realtime, presence: true
  validates :bill, presence: true
end
