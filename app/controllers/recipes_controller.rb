class RecipesController < ApplicationController
  def index
    fridge_scan = FridgeScan.find(params[:fridge_scan_id])
    @recipes = fridge_scan.recipes
  end

  def add_favorite
    @recipe = Recipe.find(params[:id])
    @recipe.favourite = true
    if @recipe.save!
      redirect_to fridge_scan_recipes_path(FridgeScan.find(params[:fridge_scan_id]))
    else
      render :index, status: :unprocessable_entity
    end
  end

  def remove_favorite
    @recipe = Recipe.find(params[:id])
    @recipe.favourite = false
    if @recipe.save!
      redirect_to fridge_scan_recipes_path(FridgeScan.find(params[:fridge_scan_id]))
    else
      render :index, status: :unprocessable_entity
    end
  end

end
