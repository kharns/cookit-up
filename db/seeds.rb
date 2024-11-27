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


puts "Creating 3 users..."
# users = User.all
user1 = User.create!(name: "bob", email: "bob@bob.com", password: "123456")
user2 = User.create!(name: "tom", email: "tom@tom.com", password: "123456")
user3 = User.create!(name: "jo", email: "jo@jo.com", password: "123456")

puts "Creating 10 fridge scans..."
ingredients = [
  "tomato", "lettuce", "cheddar cheese", "mozzarella", "chicken breast", "ground beef", "carrot", "red onion",
  "potato", "garlic", "bell pepper", "cucumber", "spinach", "mushroom", "egg", "milk", "Greek yogurt",
  "whole wheat bread", "pasta", "brown rice", "apple", "banana", "orange", "lemon", "olive oil", "butter",
  "salt", "black pepper", "sugar", "all-purpose flour", "bacon", "salmon fillet", "broccoli", "cauliflower",
  "zucchini", "eggplant", "asparagus", "green beans", "peas", "corn", "avocado", "kale", "celery", "beets",
  "sweet potato", "pumpkin", "squash", "parsley", "cilantro", "basil", "thyme", "rosemary", "oregano",
  "soy sauce", "mustard", "mayonnaise", "ketchup", "hot sauce", "vinegar", "honey", "maple syrup",
  "peanut butter", "almond milk", "coconut milk", "tofu", "tempeh", "quinoa", "oats", "almonds", "walnuts",
  "cashews", "sunflower seeds", "chia seeds", "flax seeds", "raisins", "dried cranberries", "chocolate chips",
  "vanilla extract", "baking powder", "baking soda", "yeast", "cream cheese", "sour cream", "heavy cream",
  "buttermilk", "feta cheese", "parmesan cheese", "goat cheese", "blue cheese", "ham", "turkey", "salami",
  "prosciutto", "tuna", "sardines", "shrimp", "crab meat", "clams", "mussels", "capers", "olives", "pickles",
  "sun-dried tomatoes", "artichoke hearts", "roasted red peppers", "jalapeños", "chili powder", "cumin",
  "paprika", "cinnamon", "nutmeg", "ginger", "turmeric", "cardamom", "coriander", "fennel seeds"
]

fridge_scans = []
10.times do
  fridge_scans << FridgeScan.create!(
    ingredient_list: ingredients.sample(rand(8..15)).join(", "),
    user: [user1, user2, user3].sample
  )
end

puts "Created #{FridgeScan.count} fridge scans"


puts "Creating 10 recipes..."
recipes = [
  {
    title: "Spaghetti Carbonara",
    ingredient_list: "spaghetti, eggs, pancetta, parmesan cheese, black pepper",
    content: "A creamy and savory Italian classic",
    cooking_time: "25 minutes",
    difficulty: 3,
    guest: 4,
    favourite: true,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Caesar Salad",
    ingredient_list: "romaine lettuce, croutons, parmesan cheese, grilled chicken, caesar dressing",
    content: "A fresh and crunchy salad with a creamy dressing",
    cooking_time: "20 minutes",
    difficulty: 2,
    guest: 2,
    favourite: false,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Beef Stroganoff",
    ingredient_list: "beef sirloin, mushrooms, onions, sour cream, egg noodles",
    content: "A hearty Russian dish with tender beef and a creamy sauce",
    cooking_time: "35 minutes",
    difficulty: 3,
    guest: 4,
    favourite: true,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Vegetable Stir-Fry",
    ingredient_list: "mixed vegetables, tofu, soy sauce, ginger, garlic, sesame oil",
    content: "A quick and healthy vegetarian dish packed with flavors",
    cooking_time: "15 minutes",
    difficulty: 2,
    guest: 3,
    favourite: false,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Chocolate Lava Cake",
    ingredient_list: "dark chocolate, butter, eggs, sugar, flour",
    content: "A decadent dessert with a gooey chocolate center",
    cooking_time: "18 minutes",
    difficulty: 1,
    guest: 2,
    favourite: true,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Grilled Salmon with Lemon-Dill Sauce",
    ingredient_list: "salmon fillet, lemon, dill, Greek yogurt, garlic",
    content: "A light and flavorful seafood dish perfect for summer",
    cooking_time: "22 minutes",
    difficulty: 3,
    guest: 4,
    favourite: true,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Homemade Pizza Margherita",
    ingredient_list: "pizza dough, tomato sauce, fresh mozzarella, basil leaves, olive oil",
    content: "A classic Italian pizza with simple, fresh ingredients",
    cooking_time: "30 minutes",
    difficulty: 3,
    guest: 3,
    favourite: false,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Chicken Noodle Soup",
    ingredient_list: "chicken breast, egg noodles, carrots, celery, onion, chicken broth",
    content: "A comforting soup that's perfect for cold days",
    cooking_time: "45 minutes",
    difficulty: 2,
    guest: 6,
    favourite: true,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Beef Tacos",
    ingredient_list: "ground beef, taco shells, lettuce, tomato, cheese, sour cream",
    content: "A fun and customizable Mexican-inspired meal",
    cooking_time: "25 minutes",
    difficulty: 2,
    guest: 4,
    favourite: false,
    fridge_scan_id: fridge_scans.sample.id
  },
  {
    title: "Mushroom Risotto",
    ingredient_list: "arborio rice, mushrooms, onion, white wine, parmesan cheese, vegetable broth",
    content: "A creamy Italian rice dish with earthy mushroom flavors",
    cooking_time: "40 minutes",
    difficulty: 1,
    guest: 4,
    favourite: true,
    fridge_scan_id: fridge_scans.sample.id
  }
]

recipes.each do |recipe_data|
  recipe = Recipe.new(recipe_data)
  recipe.save!
end

puts "#{Recipe.count} recipes created."
puts "Seed completed!"
