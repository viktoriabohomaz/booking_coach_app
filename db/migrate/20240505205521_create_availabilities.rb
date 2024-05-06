class CreateAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.string :available_at
      t.string :available_until
      t.string :time_zone
      t.string :day_of_week
      t.references :coach, null: false, foreign_key: true

      t.timestamps
    end
  end
end
