class CreateTimeSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :time_slots do |t|
      t.references :coach, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :available, default: true
      

      t.timestamps
    end
  end
end
