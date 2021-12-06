class CreateCandidatesProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates_projects do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
