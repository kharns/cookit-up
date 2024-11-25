class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :ingredient_list
      t.text :content
      t.boolean :favourite
      t.string :cooking_time
      t.integer :difficulty
      t.references :fridge_scan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
