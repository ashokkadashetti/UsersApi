class ProjectBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :description, :bill
  end

  view :association do
    fields :name, :description, :bill
    association :candidates, blueprint: CandidateBlueprint, view: :normal
  end
end
