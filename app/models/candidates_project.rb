# frozen_string_literal: true

# class
class CandidatesProject < ApplicationRecord
  belongs_to :candidate
  belongs_to :project
end
