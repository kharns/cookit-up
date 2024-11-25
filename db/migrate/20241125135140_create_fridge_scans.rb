class CreateFridgeScans < ActiveRecord::Migration[7.1]
  def change
    create_table :fridge_scans do |t|
      t.string :ingredient_list
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
