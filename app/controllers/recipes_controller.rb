require "json"

class RecipesController < ApplicationController
skip_before_action :authenticate_user!, only: %i[create index show]

  def create
    @fridge_scan = FridgeScan.find(params[:fridge_scan_id])
    # pour éviter de générer de nouvelles recettes lorsqu'on revient en arrière
    # puis qu'on recherche sans changer les paramètres, il faudrait ajouter une/des colonne(s)
    # "paramètres de recherche" dans la recette pour pouvoir vérifier s'ils ont changé
    # Ne pas afficher les recettes précédentes si changement de params

    # call of the private method that generates recipes
    recipes = generate_recipes
    # for each recipe => create new recipe
    recipes.each do |recipe|
      # CREATE RECIPE
      new_recipe = Recipe.new(
        title: recipe["title"],
        ingredient_list: recipe["ingredient_list"].join('%%'),
        difficulty: recipe["difficulty"],
        cooking_time: recipe["cooking_time"],
        content: recipe["cooking_steps"].join('%%'), # Join with %% so that we can retrieve easily each step in the recipe show
        guest: params[:recipe][:guest],
        fridge_scan: @fridge_scan
      )
      # call of the private method that generates image and attach it to the recipe
      # generate_recipe_image(new_recipe)

      # SAVE THE RECIPE
      new_recipe.save
    end
    # REDIRECT TO Recipes index
    redirect_to fridge_scan_recipes_path(@fridge_scan)
  end

  def index
    fridge_scan = FridgeScan.find(params[:fridge_scan_id])
    @recipes = fridge_scan.recipes.sort_by(&:created_at)
  end

  def add_favorite
    @recipe = Recipe.find(params[:id])
    @recipe.favourite = true
    if @recipe.save!
      redirect_back(fallback_location: recipe_path(@recipe))
    else
      render :index, status: :unprocessable_entity
    end
  end

  def remove_favorite
    @recipe = Recipe.find(params[:id])
    @recipe.favourite = false
    if @recipe.save!
      redirect_back(fallback_location: recipe_path(@recipe))
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def favourites
    if params[:query].present?
        @recipes = Recipe.search_by_all(params[:query])
    else
        @recipes = current_user.recipes.where(favourite: true)
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:guest, :difficulty, :cooking_time)
  end

  def set_openai_message
    # on récupère les paramètres de recherches
    number_of_guests = params[:recipe][:guest]
    search_difficulty = params[:recipe][:difficulty]
    search_ingredients = params[:recipe][:ingredient_ids]

    # définition du nombre de recettes à générer
    recipes_count = 4

    # en appliquant les paramètres de recherche s'il y en a
    difficulty_instruction = case search_difficulty
    when "1"
      "return only easy recipes (1 out of 3)"
    when "2"
      "return only easy and medium recipes (1 and 2 out of 3)"
    else
      "return at least one recipe from each difficulty (1, 2 and 3)"
    end

    # Message à transmettre à OpenAI
    message = "I want a list of #{recipes_count} different recipes, following these instructions:
    Here are all the ingredients available for the recipes: #{search_ingredients.join(', ')}.
    The recipes are for #{number_of_guests} people.
    Difficulty rank for the recipes goes from 1 (easy) to 3 (difficult). #{difficulty_instruction}.
    the recipe format I want is a JSON with these keys : title, ingredient_list, difficulty, cooking_time (in minutes),
    cooking_steps.
    Here is the cooking_steps template : ['step1:xxxxx','step2:xxxxx'].
    Don't add any comment in the ingredient_list, only ingredients and their quantities in an array, exemple : ['500g of ingredient1', '10cl of ingredient2', '3 ingredient3']
    IMPORTANT : I need #{recipes_count} recipes."

    return message
  end

  # Méthode de génération d'un array de recettes via OpenAI
  def generate_recipes
    # Appel de la méthode privée de création du message à transmettre à OpenAI
    message = set_openai_message
    client = OpenAI::Client.new
    # Paramètres de la requête
    request = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        response_format: { type: "json_object" }, # pour obtenir un format JSON en sortie
        messages: [{ role: "user", content: message }],
        temperature: 0.7 # standard sur OpenAI, définit la précision de la réponse
      })

    # Récupération de la réponse d'OpenAI
    @serialized_response = request.dig("choices", 0, "message", "content")
    # On extrait de la réponse l'array de recettes
    recipes = JSON.parse(@serialized_response)["recipes"]
    return recipes
  end
end
