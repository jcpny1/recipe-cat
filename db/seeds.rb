# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

cup    = Unit.create!(name: 'cup'   )
floz   = Unit.create!(name: 'fl oz' )
gallon = Unit.create!(name: 'gallon')
ounce  = Unit.create!(name: 'ounce' )
pound  = Unit.create!(name: 'pound' )
pint   = Unit.create!(name: 'pint'  )
quart  = Unit.create!(name: 'quart' )
tbl    = Unit.create!(name: 'tbl'   )
tsp    = Unit.create!(name: 'tsp'   )
pinch  = Unit.create!(name: 'pinch' )

user_facebook = User.create!(email: 'jpfingst@outlook.com', password: 'fakeone', provider: 'facebook', uid: '1376916635679797', role: "user")
user_admin    = User.create!(email: 'pfingst@yahoo.com',    password: '123456', role: "admin")
user_other    = User.create!(email: 'joe_user@aol.com',     password: '123456', role: "user" )
user_vip      = User.create!(email: 'joe_vip@aol.com',      password: '123456', role: "vip"  )
user_unkown   = User.create!(email: 'joe_unkown@aol.com',   password: '123456')

basil                   = Ingredient.create!(name: 'Basil',                       photo_path: 'ingredients/Basil-Basilico-Ocimum_basilicum-albahaca.jpg', description: 'The type used in Italian food is typically called sweet basil (or Genovese basil), as opposed to Thai basil, lemon basil, and holy basil, which are used in Asia.')
breadCrumbsPanko        = Ingredient.create!(name: 'Bread Crumbs, Panko',         photo_path: 'ingredients/Panko-Bread-Crumbs.jpg', description: 'Panko is a variety of flaky bread crumb used in Japanese cuisine as a crunchy coating for fried foods, such as tonkatsu.')
cheeseMozzarella        = Ingredient.create!(name: 'Cheese, Mozzarella',          photo_path: 'ingredients/Mozzarella.jpg', description: 'Mozzarella is a southern Italian cheese traditionally made from Italian buffalo milk by the pasta filata method.')
cheeseParmesanGrated    = Ingredient.create!(name: 'Cheese, Parmesan, grated',    photo_path: 'ingredients/grated-parmesan.jpg', description: 'Parmigiano-Reggiano or Parmesan cheese, is a hard, granular cheese. It is named after the producing areas, which comprise the provinces of Parma, Reggio Emilia, Bologna, Modena, and Mantua, Italy. A hand grater can be used to manually grate the cheese, or cheese can be bought already grated. Grated cheese is much finer than shredded cheese and reacts differently in recipes or application to cooked foods.')
cheeseProvoloneGrated   = Ingredient.create!(name: 'Cheese, Provolone, grated',   photo_path: 'ingredients/provolone-grated.jpg', description: 'Provolone is a semi-hard cheese with taste varying greatly from provolone piccante (sharp/piquant), aged for a minimum of four months and with a very sharp taste, to provolone dolce (sweet) with a very mild taste. Grated cheese is much finer than shredded cheese and reacts differently in recipes or application to cooked foods.')
cheeseProvoloneShredded = Ingredient.create!(name: 'Cheese, Provolone, shredded', photo_path: 'ingredients/provolone-cheese-shredded.jpg', description: 'Provolone is a semi-hard cheese with taste varying greatly from provolone piccante (sharp/piquant), aged for a minimum of four months and with a very sharp taste, to provolone dolce (sweet) with a very mild taste. Grated cheese is much finer than shredded cheese and reacts differently in recipes or application to cooked foods.')
chickenBreasts          = Ingredient.create!(name: 'Chicken, Breasts',            photo_path: 'ingredients/chicken-breasts.jpg', description: 'Chicken breasts are white meat and are relatively dry.')
duckLeg                 = Ingredient.create!(name: 'Duck, Legs',                  photo_path: 'ingredients/duck_legs.jpg', description: 'Duck meat is derived primarily from the breasts and legs of ducks. The meat of the legs is darker and somewhat fattier than the meat of the breasts, although the breast meat is darker than the breast meat of a chicken or a turkey. Being waterfowl, ducks have a layer of heat-insulating subcutaneous fat between the skin and the meat.')
eggs                    = Ingredient.create!(name: 'Eggs',                        photo_path: 'ingredients/eggs.jpg', description: 'Eggs are laid by female animals of many different species, including birds, reptiles, amphibians, mammals, and fish, and have been eaten by humans for thousands of years. Bird and reptile eggs consist of a protective eggshell, albumen (egg white), and vitellus (egg yolk), contained within various thin membranes. The most popular choice for egg consumption are chicken eggs. Other popular choices for egg consumption are duck, quail, roe, and caviar.')
flourAllPurpose         = Ingredient.create!(name: 'Flour, all-purpose',          photo_path: 'ingredients/All-Purpose-Flour.jpg', description: 'Although there are many types of flour, all-purpose (or occident) flour is used most frequently. Bread flour is higher in protein. Unbleached flour is simply not as white as bleached.')
sauceTomato             = Ingredient.create!(name: 'Sauce, Tomato',               photo_path: 'ingredients/Tomato_Sauce.jpg', description: 'Tomato sauce (also known as Neapolitan sauce, and referred to in Italy as Napoletana sauce), refers to any of a very large number of sauces made primarily from tomatoes, usually to be served as part of a dish (rather than as a condiment). Tomato sauces are common for meat and vegetables, but they are perhaps best known as sauces for pasta dishes.')
shrimp                  = Ingredient.create!(name: 'Shrimp',                      photo_path: 'ingredients/shrimp.jpg', description: 'Under the broader definition, shrimp may be synonymous with prawn, covering stalk-eyed swimming crustaceans with long narrow muscular tails (abdomens), long whiskers (antennae), and slender legs. Any small crustacean which resembles a shrimp tends to be called one.')
spaghettiThin           = Ingredient.create!(name: 'Spaghetti, Thin',             photo_path: 'ingredients/thin-spaghetti-pasta-20-lbs.jpg', description: 'There are many different varieties of pasta, a staple dish of Italian cuisine. Some pasta varieties are uniquely regional and not widely known; some types may have different names in different languages, or sometimes in the same language. For example, the cut rotelle is also called ruote in Italy and wagon wheels in the United States. Manufacturers and cooks often invent new shapes of pasta; or may invent new names for old shapes for marketing reasons. Italian pasta names often end with the masculine plural suffixes -ini, -elli, -illi, -etti or the feminine plurals -ine, -elle etc., all conveying the sense of "little"; or with -oni, -one, meaning "large". Many other suffixes like -otti ("largish") and -acci ("rough", "badly made") may occur, too. In Italian, all pasta type names are plural.')
tomatoWhole             = Ingredient.create!(name: 'Tomato, Whole',               photo_path: 'ingredients/whole-tomatos.jpg', description: 'Canned tomatoes, or tinned tomatoes, are tomatoes, usually peeled, that are sealed into a can after having been processed by heat.')
water                   = Ingredient.create!(name: 'Water',                       photo_path: 'ingredients/water.jpg', description: "Water is a transparent and nearly colorless chemical substance that is the main constituent of Earth's streams, lakes, and oceans, and the fluids of most living organisms. Its chemical formula is H2O.")
oilOlive                = Ingredient.create!(name: 'Oil, Olive',                  photo_path: 'ingredients/Olive-Oil.jpg', description: 'Olive oil is a liquid fat obtained from olives (the fruit of Olea europaea; family Oleaceae), a traditional tree crop of the Mediterranean Basin. The oil is produced by pressing whole olives. It is commonly used in cooking, whether for frying or as a salad dressing. It is also used in cosmetics, pharmaceuticals, and soaps, and as a fuel for traditional oil lamps, and has additional uses in some religions. It is associated with the "Mediterranean diet" for its possible health benefits.')

duck_fesenjan_recipe = Recipe.create!(
  user: user_other,
  name: 'Duck Fesenjan',
  photo_path: 'recipes/duck fesenjan.jpg',
  description: "Chef John's take on the classic Persian savory stew fesenjan features duck, pomegranate, and walnuts.",
  total_time: 210
  )
  duck_fesenjan_recipe.recipe_ingredients.new(ingredient: duckLeg,               quantity:  8.0,   unit: nil     )
  duck_fesenjan_recipe.save!

parmesan_chicken_recipe = Recipe.create!(
  user: user_admin,
  name: 'Chicken Parmesan',
  photo_path: 'recipes/cparm_001.jpg',
  description: 'A classic Italian dish prepared with tomato sauce and mozzarella, with a few additions by Chef John. Sure to impress your friends and family!',
  total_time: 60
  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: basil,                 quantity:  0.25,  unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: breadCrumbsPanko,      quantity:  4.0,   unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: cheeseMozzarella,      quantity:  0.25,  unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: cheeseParmesanGrated,  quantity:  0.75,  unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: cheeseProvoloneGrated, quantity:  0.5,   unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: chickenBreasts,        quantity:  2.0,   unit: pound)
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: eggs,                  quantity:  2.0,   unit: nil  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: flourAllPurpose,       quantity:  2.0,   unit: tbl  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: oilOlive,              quantity:  1.0,   unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: sauceTomato,           quantity:  4.0,   unit: floz )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: oilOlive,              quantity:  1.0,   unit: tbl  )

  step = 0
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Preheat an oven to 450 degrees F (230 degrees C).')
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Place chicken breasts between two sheets of heavy plastic (resealable freezer bags work well) on a solid, level surface. Firmly pound chicken with the smooth side of a meat mallet to a thickness of 1/2-inch. Season chicken thoroughly with salt and pepper.')
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Beat eggs in a shallow bowl and set aside.')
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Mix bread crumbs and 1/2 cup Parmesan in a separate bowl, set aside.')
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Place flour in a sifter or strainer; sprinkle over chicken breasts, evenly coating both sides.')
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Dip flour coated chicken breast in beaten eggs. Transfer breast to breadcrumb mixture, pressing the crumbs into both sides. Repeat for each breast. Set aside breaded chicken breasts for about 15 minutes.')
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Heat 1 cup olive oil in a large skillet on medium-high heat until it begins to shimmer. Cook chicken until golden, about 2 minutes on each side. The chicken will finish cooking in the oven.')
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Place chicken in a baking dish and top each breast with about 1/3 cup of tomato sauce. Layer each chicken breast with equal amounts of mozzarella cheese, fresh basil, and provolone cheese. Sprinkle 1 to 2 tablespoons of Parmesan cheese on top and drizzle with 1 tablespoon olive oil.')
  parmesan_chicken_recipe.recipe_steps.new(step_number:  step += 1, description: 'Bake in the preheated oven until cheese is browned and bubbly, and chicken breasts are no longer pink in the center, 15 to 20 minutes. An instant-read thermometer inserted into the center should read at least 165 degrees F (74 degrees C).')
  parmesan_chicken_recipe.save!

salsa_chicken_recipe = Recipe.create!(
  user: user_admin,
  name: 'Salsa Chicken',
  photo_path: 'recipes/salsa-chicken.jpg',
  description: 'Chicken seasoned with taco seasoning and topped with salsa, then baked.',
  total_time: 45
  )

tofurkey_recipe = Recipe.create!(
  user: user_other,
  name: 'Tofu Turkey',
  photo_path: 'recipes/tofurkey2.jpg',
  description: 'Just tofu really',
  total_time: 125
  )
  step = 0
  tofurkey_recipe.recipe_steps.new(step_number:  step += 1, description: 'Go to tofurkey store.')
  tofurkey_recipe.save!

  garlic_shrimp_recipe = Recipe.create!(
    user: user_admin,
    name: 'Garlic Shrimp',
    photo_path: 'recipes/garlic_shrimp.jpg',
    description: 'If you like shrimp and LOVE garlic, I hope you give this fast and delicious recipe a try soon. Enjoy!',
    total_time: 25
    )
    garlic_shrimp_recipe.recipe_ingredients.new(ingredient: oilOlive,              quantity:  1.5,   unit: tbl  )
    garlic_shrimp_recipe.recipe_ingredients.new(ingredient: shrimp,                quantity:  1.0,   unit: pound)
    garlic_shrimp_recipe.save!

user_other.user_recipe_favorites.new(recipe: salsa_chicken_recipe)
user_other.recipe_reviews.new(recipe: garlic_shrimp_recipe, stars: 5, title: 'Best garlic shrimp!', comments: 'Very tasty and easy meal to make. I marinated the shrimp with italian dressing. Worked great! Shrimp did not dry out and the seasoning was just right!')
user_other.recipe_reviews.new(recipe: salsa_chicken_recipe, stars: 5, title: 'Best salsa chicken!', comments: 'Very tasty and easy meal to make. I marinated the chicken with the package of taco seasoning and 2/3 cup of water so it would not come out so spicy. Worked great! Chicken did not dry out and the seasoning was just right!')
user_other.save!

user_admin.user_recipe_favorites.new(recipe: parmesan_chicken_recipe)
user_admin.recipe_reviews.new(recipe: salsa_chicken_recipe, stars: 2, title: 'Not the Best salsa chicken!', comments: "I've had better.")
user_admin.save!
