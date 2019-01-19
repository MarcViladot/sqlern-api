class CreateGeneratedquizzs < ActiveRecord::Migration[5.2]
  def change
    create_table :generatedquizzs do |t|

      t.timestamps
    end
  end
end
