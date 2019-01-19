class AddColumnToGeneratedquizz < ActiveRecord::Migration[5.2]
  def change
    add_column :generatedquizzs, :code, :string
  end
end
