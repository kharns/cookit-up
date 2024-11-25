class ChangeFavouriteInRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column :recipes, :favourite, :boolean, default: false
  end
end
