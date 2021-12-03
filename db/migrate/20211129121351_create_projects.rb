class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :idle
      t.string :realtime
      t.string :bill

      t.timestamps
    end
  end
end
