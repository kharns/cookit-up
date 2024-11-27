require 'cloudinary'
require "open-uri"

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


# Creating recipes and associating them with fridge scans and photos

# Recipe 1: Beef Stroganoff
file = URI.parse("https://ohsnapmacros.com/wp-content/uploads/2023/12/beefstroganoff.jpg").open
recipe1 = Recipe.new(
  title: "Beef Stroganoff",
  ingredient_list: "beef sirloin, mushrooms, onions, sour cream, egg noodles",
  content: "A hearty Russian dish with tender beef and a creamy sauce.",
  cooking_time: "35 minutes",
  difficulty: 3,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
recipe1.photo.attach(io: file, filename: "#{recipe1.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe1.save!

# Recipe 2: Vegetable Stir-Fry
file = URI.parse("https://kristineskitchenblog.com/wp-content/uploads/2024/01/vegetable-stir-fry-22-3.jpg").open
recipe2 = Recipe.new(
  title: "Vegetable Stir-Fry",
  ingredient_list: "mixed vegetables, tofu, soy sauce, ginger, garlic",
  content: "A quick and healthy vegetarian dish packed with flavors.",
  cooking_time: "15 minutes",
  difficulty: 2,
  guest: 3,
  favourite: false,
  fridge_scan_id: fridge_scans.sample.id
)
recipe2.photo.attach(io: file, filename: "#{recipe2.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe2.save!

# Recipe 3: Chocolate Lava Cake
file = URI.parse("https://www.acouplecooks.com/wp-content/uploads/2022/02/Lava-Cake-005s.jpg").open
recipe3 = Recipe.new(
  title: "Chocolate Lava Cake",
  ingredient_list: "dark chocolate, butter, eggs, sugar, flour",
  content: "A decadent dessert with a gooey chocolate center.",
  cooking_time: "18 minutes",
  difficulty: 1,
  guest: 2,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
recipe3.photo.attach(io: file, filename: "#{recipe3.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe3.save!

# Recipe 4: Grilled Salmon with Lemon-Dill Sauce
file = URI.parse("https://cookaifood.com/media/cache/thumb_600/bundles/project/images/recipes/2250_1_1703256451.png").open
recipe4 = Recipe.new(
  title: "Grilled Salmon with Lemon-Dill Sauce",
  ingredient_list: "salmon fillet, lemon, dill, Greek yogurt, garlic",
  content: "A light and flavorful seafood dish perfect for summer.",
  cooking_time: "22 minutes",
  difficulty: 3,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
recipe4.photo.attach(io: file, filename: "#{recipe4.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe4.save!

# Recipe 5: Homemade Pizza Margherita
file = URI.parse("https://kitchenswagger.com/wp-content/uploads/2023/05/margherita-pizza-close.jpg").open
recipe5 = Recipe.new(
  title: "Homemade Pizza Margherita",
  ingredient_list: "pizza dough, tomato sauce, fresh mozzarella, basil leaves",
  content: "A classic Italian pizza with simple and fresh ingredients.",
  cooking_time: "30 minutes",
  difficulty: 3,
  guest: 3,
  favourite: false,
  fridge_scan_id: fridge_scans.sample.id
)
recipe5.photo.attach(io: file, filename: "#{recipe5.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe5.save!

# Recipe 6: Chicken Noodle Soup
file = URI.parse("https://www.cubesnjuliennes.com/wp-content/uploads/2022/01/Homemade-Chicken-Noodle-Soup-Recipe.jpg").open
recipe6 = Recipe.new(
  title: "Chicken Noodle Soup",
  ingredient_list: "chicken breast, egg noodles, carrots, celery, onion",
  content: "A comforting soup that's perfect for cold days.",
  cooking_time: "45 minutes",
  difficulty: 2,
  guest: 6,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
recipe6.photo.attach(io: file, filename: "#{recipe6.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe6.save!

# Recipe 7: Beef Tacos
file = URI.parse("https://danosseasoning.com/wp-content/uploads/2022/03/Beef-Tacos-1024x767.jpg").open
recipe7 = Recipe.new(
  title:"Beef Tacos",
  ingredient_list:"ground beef,taco shells,lettuce,tomato cheese,sour cream",
  content:"A fun and customizable Mexican-inspired meal.",
  cooking_time:"25 minutes",
  difficulty:"2",
  guest:"4",
  favourite:false,
  fridge_scan_id: fridge_scans.sample.id
)
recipe7.photo.attach(io:file ,filename:"#{ recipe7.title.parameterize }.jpg",content_type:'image/jpeg')
recipe7.save!

# 8 Mushroom Risotto
recipe8 = Recipe.new(
  title: "Mushroom Risotto",
  ingredient_list: "arborio rice, mushrooms, onion, white wine, parmesan cheese, vegetable broth",
  content: "A creamy Italian rice dish with earthy mushroom flavors",
  cooking_time: "40 minutes",
  difficulty: 1,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://www.allrecipes.com/thmb/854efwMYEwilYjKr0FiF4FkwBvM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/85389-gourmet-mushroom-risotto-DDMFS-4x3-a8a80a8deb064c6a8f15452b808a0258.jpg").open
recipe8.photo.attach(io: file, filename: "#{recipe8.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe8.save!

# 9 Carbonara
recipe9 = Recipe.new(
  title: "Spaghetti Carbonara",
  ingredient_list: "spaghetti, eggs, pancetta, parmesan cheese, black pepper",
  content: "A creamy and savory Italian classic.",
  cooking_time: "25 minutes",
  difficulty: 3,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://assets.bonappetit.com/photos/5a6f48f94f860a026c60fd71/1:1/w_2560%2Cc_limit/pasta-carbonara.jpg").open
recipe9.photo.attach(io: file, filename: "#{recipe9.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe9.save!

# 10 Caesar Salad
recipe10 = Recipe.new(
  title: "Caesar Salad",
  ingredient_list: "romaine lettuce, croutons, parmesan cheese, grilled chicken, caesar dressing",
  content: "A fresh and crunchy salad with a creamy dressing.",
  cooking_time: "20 minutes",
  difficulty: 2,
  guest: 2,
  favourite: false,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://s23209.pcdn.co/wp-content/uploads/2023/01/220905_DD_Chx-Caesar-Salad_051-500x375.jpg").open
recipe10.photo.attach(io: file, filename: "#{recipe10.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe10.save!

puts "#{Recipe.count} recipes created."

puts "Seed completed!"
