class RemoveUserFromQuizzexercise < ActiveRecord::Migration[5.2]
  def change
    remove_column :quizzexercises, :user_id
  end
end
