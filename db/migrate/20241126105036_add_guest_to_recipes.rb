class AddGuestToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :guest, :integer
  end
end
