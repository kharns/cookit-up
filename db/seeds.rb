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
  content: "step1:Slice the beef sirloin into thin strips.%%step2:Fry mushrooms and onions in a pan until softened.%%step3:Cook the beef strips until browned.%%step4:Add sour cream to create a creamy sauce.%%step5:Serve the beef and sauce over cooked egg noodles.",
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
  content: "step1:Heat oil in a large skillet.%%step2:Add garlic and ginger, and sauté until fragrant.%%step3:Add mixed vegetables and cook until tender.%%step4:Stir in tofu and soy sauce, mixing well.%%step5:Serve hot.",
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
  content: "step1:Preheat the oven to 425°F (220°C).%%step2:In a bowl, melt dark chocolate and butter together.%%step3:Whisk in eggs and sugar until smooth.%%step4:Fold in flour gently until just combined.%%step5:Pour the mixture into greased ramekins and bake for 12-14 minutes.%%step6:Let cool for a minute, then invert onto a plate and serve warm.",
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
  content: "step1:Preheat the grill to medium-high heat.%%step2:In a bowl, mix Greek yogurt, lemon juice, dill, and minced garlic to create the sauce.%%step3:Season the salmon fillet with salt and pepper.%%step4:Place the salmon on the grill and cook for about 6-8 minutes per side.%%step5:Remove from the grill and drizzle with the lemon-dill sauce before serving.",
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
  content: "step1:Preheat the oven to 475°F (245°C).%%step2:Roll out the pizza dough on a floured surface to your desired thickness.%%step3:Spread a layer of tomato sauce evenly over the dough.%%step4:Place slices of fresh mozzarella on top of the sauce.%%step5:Add fresh basil leaves for flavor.%%step6:Bake in the oven for 10-15 minutes until the crust is golden and the cheese is bubbly.",
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
  content: "step1:In a large pot, bring water to a boil and add chicken breast.%%step2:Cook until the chicken is no longer pink, then remove and shred it.%%step3:Add diced onions, carrots, and celery to the pot and simmer until tender.%%step4:Stir in egg noodles and cook according to package instructions.%%step5:Add the shredded chicken back to the pot and season with salt and pepper.%%step6:Serve hot, garnished with fresh herbs if desired.",
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
  content:"step1:In a skillet, cook ground beef over medium heat until browned.%%step2:Drain excess fat and season with taco seasoning.%%step3:While the beef cooks, prepare taco shells according to package instructions.%%step4:Chop lettuce and dice tomatoes for toppings.%%step5:Assemble tacos by filling shells with beef, lettuce, tomatoes, cheese, and a dollop of sour cream.%%step6:Serve immediately with additional toppings as desired.",
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
  content: "step1:In a pot, heat vegetable broth and keep it warm over low heat.%%step2:In a separate pan, sauté chopped onions and mushrooms in olive oil until softened.%%step3:Add arborio rice to the pan and stir for a couple of minutes until the rice is translucent.%%step4:Pour in white wine and cook until absorbed.%%step5:Gradually add warm vegetable broth, one ladle at a time, stirring continuously until the rice is creamy and al dente.%%step6:Stir in grated parmesan cheese before serving.",
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
  content: "step1:Cook spaghetti according to package instructions until al dente.%%step2:In a skillet, cook pancetta over medium heat until crispy.%%step3:In a bowl, whisk together eggs, grated parmesan cheese, and black pepper.%%step4:Once the spaghetti is cooked, reserve some pasta water and drain the rest.%%step5:Add the hot spaghetti to the skillet with pancetta and remove from heat.%%step6:Quickly pour the egg mixture over the pasta, tossing to create a creamy sauce, adding reserved pasta water as needed.",
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
  content: "step1:Wash and chop romaine lettuce into bite-sized pieces.%%step2:In a large bowl, combine the chopped lettuce with croutons.%%step3:Slice grilled chicken and add it to the salad.%%step4:Sprinkle grated parmesan cheese over the top.%%step5:Drizzle Caesar dressing over the salad and toss gently to combine.%%step6:Serve immediately, garnished with extra parmesan if desired.",
  cooking_time: "20 minutes",
  difficulty: 2,
  guest: 2,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://s23209.pcdn.co/wp-content/uploads/2023/01/220905_DD_Chx-Caesar-Salad_051-500x375.jpg").open
recipe10.photo.attach(io: file, filename: "#{recipe10.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe10.save!

puts "#{Recipe.count} recipes created."

puts "Seed completed!"
