require 'faker'
require 'cloudinary'
require "open-uri"
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end




#  CHAT GPT ANSWER TEMPLATE:
# {
#   "id": "chatcmpl-AXVUgD60UirUUXYDxZhP0ENRgsvXC",
#   "object": "chat.completion",
#   "created": 1732549250,
#   "model": "gpt-4o-mini-2024-07-18",
#   "choices": [
#     {
#       "index": 0,
#       "message": {
#         "role": "assistant",
#         "content": "Sure! Here's a simple recipe for guacamole using avocado, cilantro, and lime:\n\n### Simple Guacamole Recipe\n\n**Ingredients:**\n- 2 ripe avocados\n- 1 lime (juiced)\n- 1/4 cup fresh cilantro (chopped)\n- Salt to taste\n- Optional: diced onion, diced tomato, or minced garlic for added flavor\n\n**Instructions:**\n\n1. **Prepare the Avocados:**\n   - Cut the avocados in half, remove the pit, and scoop the flesh into a mixing bowl.\n\n2. **Mash the Avocados:**\n   - Using a fork or a potato masher, mash the avocado to your desired consistency (smooth or chunky).\n\n3. **Add Lime Juice:**\n   - Pour the lime juice over the mashed avocado. This adds flavor and helps prevent browning.\n\n4. **Mix in Cilantro:**\n   - Add the chopped cilantro to the bowl and mix well.\n\n5. **Season:**\n   - Add salt to taste. You can also include any optional ingredients if desired.\n\n6. **Serve:**\n   - Enjoy your guacamole with tortilla chips, on tacos, or as a topping for your favorite dishes!\n\n### Tips:\n- For extra flavor, you can add minced garlic, diced onion, or diced tomatoes.\n- Adjust the lime and salt according to your taste preference.\n\nEnjoy your homemade guacamole!",
#         "refusal": null
#       },
#       "logprobs": null,
#       "finish_reason": "stop"
#     }
#   ],
#   "usage": {
#     "prompt_tokens": 24,
#     "completion_tokens": 282,
#     "total_tokens": 306,
#     "prompt_tokens_details": {
#       "cached_tokens": 0,
#       "audio_tokens": 0
#     },
#     "completion_tokens_details": {
#       "reasoning_tokens": 0,
#       "audio_tokens": 0,
#       "accepted_prediction_tokens": 0,
#       "rejected_prediction_tokens": 0
#     }
#   },
#   "system_fingerprint": "fp_0705bf87c0"
# }



#  CHATGPT PROMPT TEMPLATE FOR TEXT
# client = OpenAI::Client.new
# client.chat(parameters: {
#   model: "gpt-4o-mini",
#   messages: [{ role: "user", content: "Tell me why Ruby is an elegant coding language"}]
# })

# Effacer toutes les données existantes
puts "Cleaning database..."
Recipe.destroy_all
FridgeScan.destroy_all
User.destroy_all

# # Créer des utilisateurs
# puts "Creating users..."
# user1 = User.create!(name: "Alice Dupont", email: "alice@example.com", password: "password123")
# user2 = User.create!(name: "Bob Martin", email: "bob@example.com", password: "password456")

# Créer des recettes associées aux FridgeScans
# puts "Creating recipes..."
# Recipe.create!(
#   title: "Poulet au riz",
#   ingredient_list: "Poulet, Riz, Oignons, Épices",
#   content: "1. Cuire le riz. 2. Faire revenir le poulet avec les oignons. 3. Mélanger et assaisonner.",
#   cooking_time: "30 minutes",
#   guest: 4,
#   fridge_scan: fridge_scan1,
#   favourite: true
# )

# Recipe.create!(
#   title: "Boeuf bourguignon",
#   ingredient_list: "Boeuf, Carottes, Pommes de terre, Vin rouge",
#   content: "1. Faire revenir le boeuf. 2. Ajouter les légumes et le vin. 3. Mijoter pendant 2 heures.",
#   cooking_time: "2 heures",
#   guest: 6,
#   fridge_scan: fridge_scan2,
#   favourite: false
# )

puts "Creating 10 users..."
10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password123"
  )
end

puts "Creating 10 fridge scans..."
10.times do
  FridgeScan.create!(
    ingredient_list: Array.new(5) { Faker::Food.ingredient }.join(", "),
    user: User.all.sample
  )
end

puts "Creating 10 recipes..."
10.times do
  # Upload a sample image to Cloudinary and get the URL
  recipe = Recipe.new(
    title: Faker::Food.dish,
    ingredient_list: Array.new(5) { Faker::Food.ingredient }.join(", "),
    content: Faker::Food.description,
    cooking_time: "#{Faker::Number.between(from: 10, to: 120)} minutes",
    difficulty: Faker::Number.between(from: 1, to: 5),
    guest: Faker::Number.between(from: 1, to: 8),
    fridge_scan: FridgeScan.all.sample,
    favourite: Faker::Boolean.boolean
  )

  file = URI.parse(Faker::LoremFlickr.image(size: "300x300", search_terms: ['food'])).open
  recipe.photo.attach(io: file, filename: recipe.title, content_type: "image/png")
  recipe.save
end

puts "Seed completed!"
