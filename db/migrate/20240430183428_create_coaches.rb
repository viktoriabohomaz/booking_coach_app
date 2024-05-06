class CreateCoaches < ActiveRecord::Migration[7.1]
  def change
    create_table :coaches do |t|
      t.string :name
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
