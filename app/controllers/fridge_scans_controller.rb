class FridgeScansController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create show update]

  def show
    @fridge_scan = FridgeScan.find(params[:id])
    @recipe = Recipe.new
  end

  def new
    @fridge_scan = FridgeScan.new
  end

  def create
    @fridge_scan = FridgeScan.new(scan_params)

    # User_id => optional
    @fridge_scan.user = current_user unless current_user.nil?
    @fridge_scan.save

    ######## Ingredient_list => OpenAI ########
    #  CHATGPT PROMPT FOR IMAGE (VISION)
    messages = [
      { "type": "text", "text": "give me all the ingredients I have in
        this fridge picture. not in a list, just separate the ingredients with coma.
        no introduction or conclusion. be the more precise possible, exemple if there
        are different kind of meat, name each kind as a separated item.
        Don't name the container, only food. No ending dot" },
      { "type": "image_url",
        "image_url": {
          "url": @fridge_scan.photo.url
          }
      }
    ]
    # chat initialization
    client = OpenAI::Client.new

    # response request
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini", # Required.
        messages: [{ role: "user", content: messages}], # Required.
      }
    )
    # On récupère la réponse de chatGPT
    # Prompt validé, on récupère une string d'ingrédients séparés par ","
    @fridge_scan.ingredient_list = response.dig("choices", 0, "message", "content")

    ############ END OpenAI ############

    if @fridge_scan.save
      redirect_to fridge_scan_path(@fridge_scan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @fridge_scan = FridgeScan.find(params[:id])
    # On extrait le nouvel ingrédient des paramètres du formulaire.
    new_ingredient = params[:fridge_scan][:new_ingredient]

    # On vérifie (.present?) si un nouvel ingrédient a été fourni.
    if new_ingredient.present?
      # On divise la liste actuelle d'ingrédients en un tableau (.split).
      current_ingredients = @fridge_scan.ingredient_list.split(", ")
      # On ajoute le nouvel ingrédient à ce tableau.
      current_ingredients.unshift(new_ingredient)
      # On reconvertit le tableau en chaîne de caractères et on met à jour l'attribut 'ingredient_list'.
      @fridge_scan.ingredient_list = current_ingredients.join(", ")

      # On tente de sauvegarder les modifications.
      if @fridge_scan.save
        # Si la sauvegarde réussit, on redirige vers la page de visualisation du FridgeScan avec un message de succès.
        redirect_to @fridge_scan, notice: 'Ingredient successfully add ! 🎉  '
      else
        # Si la sauvegarde échoue, on réaffiche la page show (probablement pour montrer les erreurs de validation).
        render :show
      end
    else
      # Si aucun nouvel ingrédient n'est fourni, on redirige vers la page de visualisation du FridgeScan avec un message d'alerte.
      redirect_to @fridge_scan, alert: 'Please add a valid ingredient.'
    end
  end

  private

  def scan_params
    params.require(:fridge_scan).permit(:photo)
  end
end

# TEMPLATE GPT-4 VISION REQUEST
# messages = [
#   { "type": "text", "text": "What’s in this image?"},
#   { "type": "image_url",
#     "image_url": {
#       "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg",
#     },
#   }
# ]
# response = client.chat(
#   parameters: {
#     model: "gpt-4-vision-preview", # Required.
#     messages: [{ role: "user", content: messages}], # Required.
#   }
# )
# puts response.dig("choices", 0, "message", "content")
# # => "The image depicts a serene natural landscape featuring a long wooden boardwalk extending straight ahead"
