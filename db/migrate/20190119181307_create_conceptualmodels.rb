class CreateConceptualmodels < ActiveRecord::Migration[5.2]
  def change
    create_table :conceptualmodels do |t|
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
