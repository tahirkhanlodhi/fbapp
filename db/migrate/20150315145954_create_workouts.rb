class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :workout_name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id
      t.timestamps
    end
  end
end
