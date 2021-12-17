class UserBlueprint < Blueprinter::Base
  identifier :id

  view :association do
    fields :name, :email, :role
    association :candidates, blueprint: CandidateBlueprint, view: :normal
  end

  view :normal do
    fields :name, :email, :role
  end
end
