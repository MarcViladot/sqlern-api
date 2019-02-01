class AddNameToConceptualmodel < ActiveRecord::Migration[5.2]
  def change
    add_column :conceptualmodels, :name, :string
  end
end
