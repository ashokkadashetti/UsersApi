# frozen_string_literal: true

# class
class CandidatesProject < ApplicationRecord
  self.table_name = 'candidates_projects'
  belongs_to :candidate
  belongs_to :project
end
