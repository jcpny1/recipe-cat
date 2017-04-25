# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cup    = Unit.create(name: 'cup'   )
floz   = Unit.create(name: 'fl oz' )
gallon = Unit.create(name: 'gallon')
none   = Unit.create(name: ''      )
ounce  = Unit.create(name: 'ounce' )
pound  = Unit.create(name: 'pound' )
pinch  = Unit.create(name: 'pinch' )
pint   = Unit.create(name: 'pint'  )
quart  = Unit.create(name: 'quart' )
tbl    = Unit.create(name: 'tbl'   )
tsp    = Unit.create(name: 'tsp'   )

user_facebook = User.create(email: 'jpfingst@outlook.com', password: 'fakeone', provider: 'facebook', uid: '1376916635679797')
user_local    = User.create(email: 'pfingst@yahoo.com', password: '123456')
user_other    = User.create(email: 'harry@aol.com', password: '123456')

Basil                   = Ingredient.create(name: 'Basil',                       photo_path: 'ingredients/Basil-Basilico-Ocimum_basilicum-albahaca.jpg', description: 'The type used in Italian food is typically called sweet basil (or Genovese basil), as opposed to Thai basil, lemon basil, and holy basil, which are used in Asia.')
BreadCrumbsPanko        = Ingredient.create(name: 'Bread Crumbs, Panko',         photo_path: 'ingredients/Panko-Bread-Crumbs.jpg', description: 'Panko is a variety of flaky bread crumb used in Japanese cuisine as a crunchy coating for fried foods, such as tonkatsu.')
CheeseMozzarella        = Ingredient.create(name: 'Cheese, Mozzarella',          photo_path: 'ingredients/Mozzarella.jpg', description: 'Mozzarella (English /ˌmɒtsəˈrɛlə/; Italian: [mottsaˈrɛlla]) is a southern Italian cheese traditionally made from Italian buffalo milk by the pasta filata method.')
CheeseParmesanGrated    = Ingredient.create(name: 'Cheese, Parmesan, grated',    photo_path: 'ingredients/grated-parmesan.jpg', description: 'Parmigiano-Reggiano or Parmesan cheese, is a hard, granular cheese. It is named after the producing areas, which comprise the provinces of Parma, Reggio Emilia, Bologna, Modena, and Mantua, Italy. A hand grater can be used to manually grate the cheese, or cheese can be bought already grated. Grated cheese is much finer than shredded cheese and reacts differently in recipes or application to cooked foods.')
CheeseProvoloneGrated   = Ingredient.create(name: 'Cheese, Provolone, grated',   photo_path: 'ingredients/provolone-grated.jpg', description: 'Provolone is a semi-hard cheese with taste varying greatly from provolone piccante (sharp/piquant), aged for a minimum of four months and with a very sharp taste, to provolone dolce (sweet) with a very mild taste. Grated cheese is much finer than shredded cheese and reacts differently in recipes or application to cooked foods.')
CheeseProvoloneShredded = Ingredient.create(name: 'Cheese, Provolone, shredded', photo_path: 'ingredients/provolone-cheese-shredded.jpg', description: 'Provolone is a semi-hard cheese with taste varying greatly from provolone piccante (sharp/piquant), aged for a minimum of four months and with a very sharp taste, to provolone dolce (sweet) with a very mild taste. Grated cheese is much finer than shredded cheese and reacts differently in recipes or application to cooked foods.')
ChickenBreasts          = Ingredient.create(name: 'Chicken, Breasts',            photo_path: 'ingredients/chicken-breasts.jpg', description: 'Chicken breasts are white meat and are relatively dry.')
Eggs                    = Ingredient.create(name: 'Eggs',                        photo_path: 'ingredients/eggs.jpg', description: 'Eggs are laid by female animals of many different species, including birds, reptiles, amphibians, mammals, and fish, and have been eaten by humans for thousands of years.[1] Bird and reptile eggs consist of a protective eggshell, albumen (egg white), and vitellus (egg yolk), contained within various thin membranes. The most popular choice for egg consumption are chicken eggs. Other popular choices for egg consumption are duck, quail, roe, and caviar.')
FlourAllPurpose         = Ingredient.create(name: 'Flour, all-purpose',          photo_path: 'ingredients/All-Purpose-Flour.jpg', description: 'Although there are many types of flour, all-purpose (or occident) flour is used most frequently. Bread flour is higher in protein. Unbleached flour is simply not as white as bleached.')
OilOlive                = Ingredient.create(name: 'Oil, Olive',                  photo_path: 'ingredients/Olive-Oil.jpg', description: 'Olive oil is a liquid fat obtained from olives (the fruit of Olea europaea; family Oleaceae), a traditional tree crop of the Mediterranean Basin. The oil is produced by pressing whole olives. It is commonly used in cooking, whether for frying or as a salad dressing. It is also used in cosmetics, pharmaceuticals, and soaps, and as a fuel for traditional oil lamps, and has additional uses in some religions. It is associated with the "Mediterranean diet" for its possible health benefits.')
SpaghettiThin           = Ingredient.create(name: 'Spaghetti, thin',             photo_path: 'ingredients/thin-spaghetti-pasta-20-lbs.jpg', description: 'There are many different varieties of pasta, a staple dish of Italian cuisine. Some pasta varieties are uniquely regional and not widely known; some types may have different names in different languages, or sometimes in the same language. For example, the cut rotelle is also called ruote in Italy and wagon wheels in the United States. Manufacturers and cooks often invent new shapes of pasta; or may invent new names for old shapes for marketing reasons. Italian pasta names often end with the masculine plural suffixes -ini, -elli, -illi, -etti or the feminine plurals -ine, -elle etc., all conveying the sense of "little"; or with -oni, -one, meaning "large". Many other suffixes like -otti ("largish") and -acci ("rough", "badly made") may occur, too. In Italian, all pasta type names are plural.')
TomatoSauce             = Ingredient.create(name: 'Tomato, sauce',               photo_path: 'ingredients/Tomato_Sauce.jpg', description: 'Tomato sauce (also known as Neapolitan sauce, and referred to in Italy as Napoletana sauce), refers to any of a very large number of sauces made primarily from tomatoes, usually to be served as part of a dish (rather than as a condiment). Tomato sauces are common for meat and vegetables, but they are perhaps best known as sauces for pasta dishes.')
TomatoWhole             = Ingredient.create(name: 'Tomato, whole',               photo_path: 'ingredients/whole-tomatos.jpg', description: 'Canned tomatoes, or tinned tomatoes, are tomatoes, usually peeled, that are sealed into a can after having been processed by heat.')

SECONDS_PER_MINUTE = 60

parmesan_chicken_recipe = Recipe.new(
  user: user_local,
  name: 'Chicken Parmesan',
  photo_path: 'recipes/cparm_001.jpg',
  description: 'A classic Italian dish prepared with tomato sauce and mozzarella, with a few additions by Chef John. Sure to impress your friends and family!',
  total_time: Time.at(60*SECONDS_PER_MINUTE)
  )

  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: Basil,                 quantity:  0.25,  unit: cup )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: BreadCrumbsPanko,      quantity:  4.0,   unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: CheeseMozzarella,      quantity:  0.25,  unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: CheeseParmesanGrated,  quantity:  0.75,  unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: CheeseProvoloneGrated, quantity:  0.5,   unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: ChickenBreasts,        quantity:  2.0,   unit: pound)
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: Eggs,                  quantity:  2.0,   unit: none )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: FlourAllPurpose,       quantity:  2.0,   unit: tbl  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: OilOlive,              quantity:  1.0,   unit: cup  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: OilOlive,              quantity:  1.0,   unit: tbl  )
  parmesan_chicken_recipe.recipe_ingredients.new(ingredient: TomatoSauce,           quantity:  4.0,   unit: floz )

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
  parmesan_chicken_recipe.save

salsa_chicken_recipe = Recipe.new(
  user: user_local,
  name: 'Salsa Chicken',
  photo_path: 'recipes/salsa-chicken.jpg',
  description: 'Chicken seasoned with taco seasoning and topped with salsa, then baked.',
  total_time: Time.at(45*SECONDS_PER_MINUTE)
  )
  salsa_chicken_recipe.save

tofurkey_recipe = Recipe.new(
  user: user_other,
  name: 'Tofu Turkey',
  photo_path: 'recipes/tofurkey2.jpg',
  description: 'Just tofu really',
  total_time: Time.at(125*SECONDS_PER_MINUTE)
  )
  tofurkey_recipe.save

user_other.user_recipe_favorites.new(recipe: salsa_chicken_recipe)
user_other.user_recipe_reviews.new(recipe: salsa_chicken_recipe, stars: 5, title: 'Best salsa chicken!', comments: 'Very tasty and easy meal to make. I marinated the chicken with the package of taco seasoning and 2/3 cup of water so it would not come out so spicy. Worked great! Chicken did not dry out and the seasoning was just right!')
user_other.save

user_local.user_recipe_favorites.new(recipe: parmesan_chicken_recipe)
user_local.user_recipe_reviews.new(recipe: salsa_chicken_recipe, stars: 2, title: 'Not the Best salsa chicken!', comments: "Meh. I've had better")
user_local.save
