class CreateTimeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :time_slots do |t|
      t.references :coach, null: false, foreign_key: true
      t.string :start_time
      t.string :end_time
      t.boolean :available, default: true
      t.string :timezone

      t.timestamps
    end
  end
end
