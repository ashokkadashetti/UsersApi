# frozen_string_literal: true

class CandidateBlueprint < Blueprinter::Base
  identifier :id

  view :association do
    fields :name, :email
    association :projects, blueprint: ProjectBlueprint, view: :normal
  end

  view :normal do
    fields :name, :email
  end
end
