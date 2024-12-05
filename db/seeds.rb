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

favorite_user = user1

puts "Creating 10 fridge scans..."
ingredients = [
  "4 medium tomatoes",
  "1 head of lettuce",
  "200 grams of cheddar cheese",
  "250 grams of mozzarella",
  "500 grams of chicken breast",
  "450 grams of ground beef",
  "3 medium carrots",
  "1 large red onion",
  "4 medium potatoes",
  "3 cloves of garlic",
  "2 bell peppers",
  "1 large cucumber",
  "200 grams of spinach",
  "250 grams of mushrooms",
  "6 eggs",
  "1 liter of milk",
  "500 grams of Greek yogurt",
  "1 loaf of whole wheat bread",
  "500 grams of pasta",
  "400 grams of brown rice",
  "2 medium apples",
  "3 bananas",
  "2 oranges",
  "2 lemons",
  "750 ml of olive oil",
  "100 grams of butter",
  "3 tsp of salt",
  "3 tsp of black pepper",
  "200 grams of sugar",
  "500 grams of all-purpose flour",
  "200 grams of bacon",
  "400 grams of salmon fillet",
  "1 head of broccoli",
  "1 head of cauliflower",
  "2 medium zucchinis",
  "1 large eggplant",
  "250 grams of asparagus",
  "250 grams of green beans",
  "200 grams of peas",
  "2 ears of corn",
  "2 avocados",
  "200 grams of kale",
  "4 stalks of celery",
  "3 medium beets",
  "2 medium sweet potatoes",
  "1 small pumpkin",
  "1 medium squash",
  "1 bunch of parsley",
  "1 bunch of cilantro",
  "1 bunch of basil",
  "3 tsp of thyme",
  "6 tsp of rosemary",
  "3 tsp of oregano",
  "100 ml of soy sauce",
  "300 ml of mustard",
  "200 grams of mayonnaise",
  "200 grams of ketchup",
  "180 ml of hot sauce",
  "100 ml of vinegar",
  "250 grams of honey",
  "600 ml of maple syrup",
  "250 grams of peanut butter",
  "1 liter of almond milk",
  "400 ml of coconut milk",
  "400 grams of tofu",
  "200 grams of tempeh",
  "250 grams of quinoa",
  "500 grams of oats",
  "100 grams of almonds",
  "100 grams of walnuts",
  "100 grams of cashews",
  "50 grams of sunflower seeds",
  "50 grams of chia seeds",
  "50 grams of flax seeds",
  "100 grams of raisins",
  "100 grams of dried cranberries",
  "100 grams of chocolate chips", "3 tsp of vanilla extract",
  "3 tsp of baking powder",
  "1 tsp of baking soda",
  "7 grams of yeast",
  "200 grams of cream cheese",
  "200 grams sour cream",
  "200 ml heavy cream",
  "500 ml buttermilk",
  "200 grams feta cheese",
  "100 grams parmesan cheese",
  "100 grams goat cheese",
  "100 grams blue cheese",
  "200 grams ham",
  "200 grams turkey",
  "100 grams salami",
  "100 grams prosciutto",
  "200 grams tuna",
  "100 grams sardines",
  "250 grams shrimp",
  "200 grams crab meat",
  "500 grams clams",
  "500 grams mussels",
  "50 grams capers",
  "100 grams olives",
  "200 grams pickles",
  "100 grams sun-dried tomatoes",
  "200 grams artichoke hearts",
  "200 grams roasted red peppers ",
  "50 g jalapeños ",
  "3 tsp of chili powder ",
  "3 tsp of cumin ",
  "3 tsp of paprika ",
  "3 tsp of cinnamon ",
  "1 tsp of nutmeg ",
  "3 tsp of ginger ",
  "3 tsp of turmeric ",
  "1 tsp of cardamom ",
  "3 tsp of coriander ",
  "3 tsp of fennel seeds"
]

fridge_scans = []
10.times do
  fridge_scans << FridgeScan.create!(
    ingredient_list: ingredients.sample(rand(8..15)).join(", "),
    user: favorite_user
  )
end

# Creating recipes and associating them with fridge scans and photos

# Recipe 1: Beef Stroganoff
file = URI.parse("https://ohsnapmacros.com/wp-content/uploads/2023/12/beefstroganoff.jpg").open
recipe1 = Recipe.new(
  title: "Beef Stroganoff",
  ingredient_list: "600g of beef sirloin%%100g of mushrooms%%2 onions%%50cl of sour cream%%500g of egg noodles",
  content: "step1:Slice the beef sirloin into thin strips.%%step2:Fry mushrooms and onions in a pan until softened.%%step3:Cook the beef strips until browned.%%step4:Add sour cream to create a creamy sauce.%%step5:Serve the beef and sauce over cooked egg noodles.",
  cooking_time: "35 minutes",
  difficulty: 3,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.first.id
)
recipe1.photo.attach(io: file, filename: "#{recipe1.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe1.save!

# Recipe 2: Vegetable Stir-Fry
file = URI.parse("https://kristineskitchenblog.com/wp-content/uploads/2024/01/vegetable-stir-fry-22-3.jpg").open
recipe2 = Recipe.new(
  title: "Vegetable Stir-Fry",
  ingredient_list: "400g of mixed vegetables%%300g of tofu%%2cl soy sauce%%20g of ginger%%2 garlic cloves",
  content: "step1:Heat oil in a large skillet.%%step2:Add garlic and ginger, and sauté until fragrant.%%step3:Add mixed vegetables and cook until tender.%%step4:Stir in tofu and soy sauce, mixing well.%%step5:Serve hot.",
  cooking_time: "15 minutes",
  difficulty: 2,
  guest: 3,
  favourite: false,
  fridge_scan_id: fridge_scans.first.id
)
recipe2.photo.attach(io: file, filename: "#{recipe2.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe2.save!

# Recipe 3: Chocolate Lava Cake
file = URI.parse("https://www.acouplecooks.com/wp-content/uploads/2022/02/Lava-Cake-005s.jpg").open
recipe3 = Recipe.new(
  title: "Chocolate Lava Cake",
  ingredient_list: "200g of dark chocolate%%100g of butter%%2 eggs%%100g of sugar%%200g of flour",
  content: "step1:Preheat the oven to 220°C.%%step2:In a bowl, melt dark chocolate and butter together.%%step3:Whisk in eggs and sugar until smooth.%%step4:Fold in flour gently until just combined.%%step5:Pour the mixture into greased ramekins and bake for 12-14 minutes.%%step6:Let cool for a minute, then invert onto a plate and serve warm.",
  cooking_time: "18 minutes",
  difficulty: 1,
  guest: 2,
  favourite: true,
  fridge_scan_id: fridge_scans.first.id
)
recipe3.photo.attach(io: file, filename: "#{recipe3.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe3.save!

# Recipe 4: Grilled Salmon with Lemon-Dill Sauce
file = URI.parse("https://cookaifood.com/media/cache/thumb_600/bundles/project/images/recipes/2250_1_1703256451.png").open
recipe4 = Recipe.new(
  title: "Grilled Salmon with Lemon-Dill Sauce",
  ingredient_list: "4 salmon fillets%%3 lemons%%dill%%2 Greek yogurts%%garlic",
  content: "step1:Preheat the grill to medium-high heat.%%step2:In a bowl, mix Greek yogurt, lemon juice, dill, and minced garlic to create the sauce.%%step3:Season the salmon fillet with salt and pepper.%%step4:Place the salmon on the grill and cook for about 6-8 minutes per side.%%step5:Remove from the grill and drizzle with the lemon-dill sauce before serving.",
  cooking_time: "22 minutes",
  difficulty: 3,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.first.id
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

# 11 Lemon Garlic Roasted Chicken
recipe11 = Recipe.new(
  title: "Lemon Garlic Roasted Chicken",
  ingredient_list: "whole chicken, lemon, garlic, rosemary, olive oil, salt, pepper",
  content: "step1:Preheat oven to 425°F (220°C).%%step2:Mix lemon juice, garlic, and herbs.%%step3:Rub mixture under and over chicken skin.%%step4:Roast for 1 hour or until cooked through.%%step5:Let rest before carving.",
  cooking_time: "1 hour 15 minutes",
  difficulty: 2,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://www.eatwell101.com/wp-content/uploads/2021/02/baked-chicken-thighs-recipe-5.jpg").open
recipe11.photo.attach(io: file, filename: "#{recipe11.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe11.save!

# 12 Vegetarian Spinach and Ricotta Lasagna
recipe12 = Recipe.new(
  title: "Vegetarian Spinach and Ricotta Lasagna",
  ingredient_list: "lasagna sheets, spinach, ricotta, mozzarella, tomato sauce, garlic, nutmeg",
  content: "step1:Mix spinach, ricotta, and nutmeg.%%step2:Layer lasagna sheets, spinach mixture, and tomato sauce.%%step3:Top with mozzarella.%%step4:Bake at 375°F (190°C) for 30-35 minutes.",
  cooking_time: "50 minutes",
  difficulty: 3,
  guest: 6,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://static01.nyt.com/images/2024/03/27/multimedia/hm-spinach-and-ricotta-torn-lasagna-gvmh/hm-spinach-and-ricotta-torn-lasagna-gvmh-jumbo.jpg?quality=75&auto=webp").open
recipe12.photo.attach(io: file, filename: "#{recipe12.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe12.save!

# 13 Teriyaki Salmon with Stir-Fried Vegetables
recipe13 = Recipe.new(
  title: "Teriyaki Salmon with Stir-Fried Vegetables",
  ingredient_list: "salmon fillets, teriyaki sauce, mixed vegetables, rice, sesame seeds",
  content: "step1:Marinate salmon in teriyaki sauce.%%step2:Grill or pan-fry salmon.%%step3:Stir-fry vegetables.%%Step4:Serve salmon over rice with vegetables.",
  cooking_time: "30 minutes",
  difficulty: 2,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://www.thefoodblog.net/wp-content/uploads/2023/04/salmon-stir-fry-6-of-13.jpg").open
recipe13.photo.attach(io: file, filename: "#{recipe13.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe13.save!

# 14 Spicy Thai Green Curry
recipe14 = Recipe.new(
  title: "Spicy Thai Green Curry",
  ingredient_list: "green curry paste, coconut milk, chicken or tofu, vegetables, fish sauce, lime leaves",
  content: "step1:Fry curry paste in oil.%%step2:Add coconut milk and simmer.%%step3:Add protein and vegetables.%%Step4:Season with fish sauce and lime leaves.%%step5:Serve with rice.",
  cooking_time: "35 minutes",
  difficulty: 3,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://as1.ftcdn.net/v2/jpg/09/88/05/66/1000_F_988056695_vkAyklAr7R8YdCQpd5ZYtAKqnLHKF3G8.jpg").open
recipe14.photo.attach(io: file, filename: "#{recipe14.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe14.save!

# 15 Homemade Beef Burgers
recipe15 = Recipe.new(
  title: "Homemade Beef Burgers",
  ingredient_list: "ground beef, onion, garlic, egg, breadcrumbs, burger buns, lettuce, tomato, cheese",
  content: "step1:Mix beef with onion, garlic, egg, and breadcrumbs.%%step2:Form into patties.%%step3:Grill or pan-fry until cooked.%%Step4:Assemble burgers with toppings.",
  cooking_time: "25 minutes",
  difficulty: 2,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://www.buywesteatbest.org.au/wp-content/uploads/2021/12/Homemade-beef-burgers-650x484-jpeg.webp").open
recipe15.photo.attach(io: file, filename: "#{recipe15.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe15.save!

# 16 Vegetable Paella
recipe16 = Recipe.new(
  title: "Vegetable Paella",
  ingredient_list: "rice, saffron, vegetable broth, bell peppers, peas, artichokes, tomatoes, garlic",
  content: "step1:Toast rice with saffron.%%step2:Add vegetables and broth.%%step3:Simmer until rice is cooked.%%Step4:Create a crispy bottom crust.",
  cooking_time: "40 minutes",
  difficulty: 3,
  guest: 6,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://realfood.tesco.com/media/images/1400x919Vegetablepaellarecipe-9e034e9a-478a-4ee9-8d7a-5c4229c206eb-0-1400x919.jpg").open
recipe16.photo.attach(io: file, filename: "#{recipe16.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe16.save!

# 17 Creamy Tomato Basil Soup
recipe17 = Recipe.new(
  title: "Creamy Tomato Basil Soup",
  ingredient_list: "tomatoes, onion, garlic, basil, cream, vegetable broth, olive oil",
  content: "step1:Sauté onion and garlic.%%step2:Add tomatoes and broth, simmer.%%step3:Blend until smooth.%%Step4:Stir in cream and basil.",
  cooking_time: "30 minutes",
  difficulty: 2,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://www.seriouseats.com/thmb/iunDAJIVV2lTiXG3bWWigO3totQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/053123_TomatoSoup-MPPSoupsAndStews-Morgan-Hunt-Glaze-f59a081d7efb4625a75a1a907a6b1cbf.jpg").open
recipe17.photo.attach(io: file, filename: "#{recipe17.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe17.save!

# 18 Lemon Herb Grilled Shrimp Skewers
recipe18 = Recipe.new(
  title: "Lemon Herb Grilled Shrimp Skewers",
  ingredient_list: "shrimp, lemon juice, olive oil, garlic, herbs, skewers",
  content: "step1:Marinate shrimp in lemon, oil, garlic, and herbs.%%step2:Thread onto skewers.%%step3:Grill for 2-3 minutes per side.%%Step4:Serve with lemon wedges.",
  cooking_time: "20 minutes",
  difficulty: 2,
  guest: 4,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://cdn.shopify.com/s/files/1/0093/2537/9669/files/original_1216936183_-_resize_2048x2048.jpg?v=1578515554").open
recipe18.photo.attach(io: file, filename: "#{recipe18.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe18.save!

# 19 Banoffee Pie
recipe19 = Recipe.new(
  title: "Banoffee Pie",
  ingredient_list: "5 bananas%%100g of caramel%%200g of cream%%100g of biscuits%%200g of chocolate",
  content: "step1:Prepare biscuit base.%%step2:Add caramel.%%step3:Layer bananas.%%Step4:Cover with cream.",
  cooking_time: "30 minutes",
  difficulty: 2,
  guest: 6,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://www.ocado.com/cmscontent/recipe_image_large/33362710.png?awth").open
recipe19.photo.attach(io: file, filename: "#{recipe19.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe19.save!

# 20 Apple Crumble
recipe20 = Recipe.new(
  title: "Apple Crumble",
  ingredient_list: "apples, flour, butter, sugar, cinnamon",
  content: "step1:Prepare apples.%%step2:Make crumble topping.%%step3:Cover fruits.%%Step4:Bake until golden.",
  cooking_time: "45 minutes",
  difficulty: 2,
  guest: 6,
  favourite: true,
  fridge_scan_id: fridge_scans.sample.id
)
file = URI.parse("https://hips.hearstapps.com/hmg-prod/images/delish-091621-apple-crumb-pie-02-jg-1632846997.jpg").open
recipe20.photo.attach(io: file, filename: "#{recipe20.title.parameterize}.jpg", content_type: 'image/jpeg')
recipe20.save!

puts "#{Recipe.count} recipes created."

puts "Seed completed!"
