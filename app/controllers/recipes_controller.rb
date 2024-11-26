class RecipesController < ApplicationController

  # params given by the "search" button : guest, difficulty, cooking_time
  def create
    # on récupère les paramètres de recherches
    # on récupère les ingrédients du fridge_scan
    # on fait le prompt a chatGPT pour récupérer :
      # X recettes avec les ingrédients du frigo
      # en appliquant les paramètres de recherche s'il y en a
        # sinon définir suivant la recette : difficulty & cooking_time
      # format des recettes : title, ingredients, steps
    # On récupère la réponse de chatGPT avec toutes nos recettes
    # on met en forme dans un array de hash (recipes)
    # on itère sur chaque recipe en faisant un Recipe.new

    fridge_ingredients = @recipe.fridge_scan.ingredient_list

    # to define : title, ingredient_list, content(steps), photo, favourite(false)
    # params : difficulty, cooking_time, guest(default: 2)
    ###### OpenAI #######
    message = ""
    client = OpenAI::Client.new
    request = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: message}]
      })

    response = request.dig("choices", 0, "message", "content")

    # for each recipe => create new recipe
      @recipe = Recipe.new
  end

  private

  def recipe_params
    params.require(:recipe).permit(:guest, :difficulty, :cooking_time)
  end
end
