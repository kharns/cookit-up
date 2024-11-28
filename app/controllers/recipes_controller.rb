require "json"
require "open-uri"

class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]

  # params given by the "search" button : guest, difficulty, cooking_time
  def create
    # on récupère les paramètres de recherches
    number_of_guests = params[:recipe][:guest]

    search_difficulty = params[:recipe][:difficulty]

    # on récupère les ingrédients du fridge_scan
    fridge_scan = FridgeScan.find(params[:fridge_scan_id])
    search_ingredients = fridge_scan.ingredient_list
    # search_ingredients = "peach, pie, oranges, blueberries, bananas, green grapes, orange juice, sandwich wrap, red bell pepper, yellow bell pepper, yogurt"
    # on fait le prompt a chatGPT pour récupérer :
    recipes_count = 3
    # X recettes avec les ingrédients du frigo
    # en appliquant les paramètres de recherche s'il y en a
    difficulty_instruction = case search_difficulty
    when "1"
      "return only easy recipes (1)"
    when "2"
      "return only easy and medium recipes (1 and 2 out of 3)"
    else
      "return at least one recipe from each difficulty (1, 2 and 3)"
    end

        # sinon définir suivant la recette : difficulty & cooking_time
      # format des recettes : title, ingredients, steps
    # On récupère la réponse de chatGPT avec toutes nos recettes
    # on met en forme dans un array de hash (recipes)
    # on itère sur chaque recipe en faisant un Recipe.new

    # IN : ingredients, params(difficulty, cooking_time, guest(default: 2))
    # OUT : title, ingredient_list, content(steps), photo, favourite(false)

    ###### OpenAI #######
    message = "I want a list of #{recipes_count} recipes, following these instructions:
    Here are all the ingredients available for the recipes: #{search_ingredients}.
    The recipes are for #{number_of_guests} people.
    Difficulty rank for the recipes goes from 1 (easy) to 3 (difficult). #{difficulty_instruction}.
    the recipe format I want is a JSON with these keys : title, ingredient_list, difficulty, cooking_time, cooking_steps"

    client = OpenAI::Client.new
    request = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        response_format: { type: "json_object" },
        messages: [{ role: "user", content: message}],
        temperature: 0.7
      })


    serialized_response = request.dig("choices", 0, "message", "content")
    recipes = JSON.parse(serialized_response)["recipes"]
    # for each recipe => create new recipe
    recipes.each do |recipe|
      # CREATE RECIPE
      new_recipe = Recipe.new(
        title: recipe["title"],
        ingredient_list: recipe["ingredient_list"],
        difficulty: recipe["difficulty"],
        cooking_time: recipe["cooking_time"],
        content: recipe["cooking_steps"].join('%%'), # Join with %% so that we can retrieve easily each step in the recipe show
        guest: number_of_guests,
        fridge_scan:
      )
      # CREATE RECIPE PHOTO
      recipe_photo = client.images.generate(parameters: {
        prompt: "A recipe image of #{new_recipe.title}", size: "256x256"
      })
      # ATTACH RECIPE PHOTO
      photo_url = recipe_photo["data"][0]["url"]
      file = URI.parse(photo_url).open
      new_recipe.photo.attach(io: file, filename: "AI #{new_recipe.title}.jpg", content_type: 'image/jpeg')
      # SAVE THE RECIPE
      new_recipe.save
    end
    # REDIRECT TO
    redirect_to fridge_scan_recipes_path(fridge_scan)
  end


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

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:guest, :difficulty, :cooking_time)
  end
end


#  CHATGPT PROMPT TEMPLATE FOR TEXT
# client = OpenAI::Client.new
# client.chat(parameters: {
#   model: "gpt-4o-mini",
#   messages: [{ role: "user", content: "Tell me why Ruby is an elegant coding language"}]
# })

# example of ingredient list
# "peach, pie, oranges, blueberries, bananas, green grapes, orange juice, sandwich wrap, red bell pepper, yellow bell pepper, yogurt"
