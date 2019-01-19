class CreateAnsweredquizzs < ActiveRecord::Migration[5.2]
  def change
    create_table :answeredquizzs do |t|
      t.references :user, foreign_key: true
      t.references :generatedquizz, foreign_key: true
      t.decimal :note

      t.timestamps
    end
  end
end
