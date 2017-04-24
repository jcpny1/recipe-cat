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

# from_unit * conversion = to_unit
conversions = UnitConversion.create([
  {from_unit: cup,    to_unit: cup,    multiplier:     1.0      },
  {from_unit: cup,    to_unit: floz,   multiplier:     8.0      }, {from_unit: floz,   to_unit: cup,    multiplier:     0.125     },
  {from_unit: cup,    to_unit: gallon, multiplier:     0.0625   }, {from_unit: gallon, to_unit: cup,    multiplier:    16.0       },
  {from_unit: cup,    to_unit: pinch,  multiplier:   768.0      }, {from_unit: pinch,  to_unit: cup,    multiplier:     0.0013021 },
  {from_unit: cup,    to_unit: pint,   multiplier:     0.5      }, {from_unit: pint,   to_unit: cup,    multiplier:     2.0       },
  {from_unit: cup,    to_unit: quart,  multiplier:     0.25     }, {from_unit: quart,  to_unit: cup,    multiplier:     4.0       },
  {from_unit: cup,    to_unit: tbl,    multiplier:    16.0      }, {from_unit: tbl,    to_unit: cup,    multiplier:     0.0625    },
  {from_unit: cup,    to_unit: tsp,    multiplier:    48.0      }, {from_unit: tsp,    to_unit: cup,    multiplier:     0.0208333 },
  {from_unit: floz,   to_unit: floz,   multiplier:     1.0      },
  {from_unit: floz,   to_unit: gallon, multiplier:     0.0078125}, {from_unit: gallon, to_unit: floz,   multiplier:   128.0       },
  {from_unit: floz,   to_unit: pinch,  multiplier:    96.0      }, {from_unit: pinch,  to_unit: floz,   multiplier:     0.0104167 },
  {from_unit: floz,   to_unit: pint,   multiplier:     0.0625   }, {from_unit: pint,   to_unit: floz,   multiplier:    16.0       },
  {from_unit: floz,   to_unit: quart,  multiplier:     0.03125  }, {from_unit: quart,  to_unit: floz,   multiplier:    32.0       },
  {from_unit: floz,   to_unit: tbl,    multiplier:     2.0      }, {from_unit: tbl,    to_unit: floz,   multiplier:     0.5       },
  {from_unit: floz,   to_unit: tsp,    multiplier:     6.0      }, {from_unit: tsp,    to_unit: floz,   multiplier:     0.1666667 },
  {from_unit: gallon, to_unit: gallon, multiplier:     1.0      },
  {from_unit: gallon, to_unit: pinch,  multiplier: 12288.0      }, {from_unit: pinch,  to_unit: gallon, multiplier:     0.0000814 },
  {from_unit: gallon, to_unit: pint,   multiplier:     8.0      }, {from_unit: pint,   to_unit: gallon, multiplier:     0.125     },
  {from_unit: gallon, to_unit: quart,  multiplier:     4.0      }, {from_unit: quart,  to_unit: gallon, multiplier:     0.25      },
  {from_unit: gallon, to_unit: tbl,    multiplier:   256.0      }, {from_unit: tbl,    to_unit: gallon, multiplier:     0.0039063 },
  {from_unit: gallon, to_unit: tsp,    multiplier:   768.0      }, {from_unit: tsp,    to_unit: gallon, multiplier:     0.0013021 },
  {from_unit: ounce,  to_unit: ounce,  multiplier:     1.0      },
  {from_unit: ounce,  to_unit: pound,  multiplier:     0.0625   }, {from_unit: pound,  to_unit: ounce,  multiplier:    16.0       },
  {from_unit: pound,  to_unit: pound,  multiplier:     1.0      },
  {from_unit: pinch,  to_unit: pinch,  multiplier:     1.0      },
  {from_unit: pinch,  to_unit: pint,   multiplier:     0.0006510}, {from_unit: pint,   to_unit: pinch,  multiplier:  1536.0       },
  {from_unit: pinch,  to_unit: quart,  multiplier:     0.0003255}, {from_unit: quart,  to_unit: pinch,  multiplier:  3072.0       },
  {from_unit: pinch,  to_unit: tbl,    multiplier:     0.0208333}, {from_unit: tbl,    to_unit: pinch,  multiplier:    48.0       },
  {from_unit: pinch,  to_unit: tsp,    multiplier:     0.0625   }, {from_unit: tsp,    to_unit: pinch,  multiplier:    16.0       },
  {from_unit: pint,   to_unit: pint,   multiplier:     1.0      },
  {from_unit: pint,   to_unit: quart,  multiplier:     0.5      }, {from_unit: quart,  to_unit: pint,   multiplier:     2.0       },
  {from_unit: pint,   to_unit: tbl,    multiplier:    32.0      }, {from_unit: tbl,    to_unit: pint,   multiplier:     0.03125   },
  {from_unit: pint,   to_unit: tsp,    multiplier:    96.0      }, {from_unit: tsp,    to_unit: pint,   multiplier:     0.0104167 },
  {from_unit: quart,  to_unit: quart,  multiplier:     1.0      },
  {from_unit: quart,  to_unit: tbl,    multiplier:    64.0      }, {from_unit: tbl,    to_unit: quart,  multiplier:     0.015625  },
  {from_unit: quart,  to_unit: tsp,    multiplier:   192.0      }, {from_unit: tsp,    to_unit: quart,  multiplier:     0.0052083 },
  {from_unit: tbl,    to_unit: tsp,    multiplier:     3.0      }, {from_unit: tsp,    to_unit: tbl,    multiplier:     0.3333333 } ])

user_local    = User.create(email: 'pfingst@yahoo.com', password: '123456')
user_facebook = User.create(email: 'jpfingst@outlook.com', password: 'fakeone', provider: 'facebook', uid: '1376916635679797')

Basil                   = Ingredient.create(name: 'Basil',                       photo_path: 'ingredients/Basil-Basilico-Ocimum_basilicum-albahaca.jpg', description: 'The type used in Italian food is typically called sweet basil (or Genovese basil), as opposed to Thai basil, lemon basil, and holy basil, which are used in Asia.')
BreadCrumbsPanko        = Ingredient.create(name: 'Bread Crumbs, Panko',         photo_path: '', description: '')
CheeseMozzarella        = Ingredient.create(name: 'Cheese, Mozzarella',          photo_path: '', description: '')
CheeseParmesanGrated    = Ingredient.create(name: 'Cheese, Parmesan, grated',    photo_path: '', description: '')
CheeseProvoloneGrated   = Ingredient.create(name: 'Cheese, Provolone, grated',   photo_path: '', description: '')
CheeseProvoloneShredded = Ingredient.create(name: 'Cheese, Provolone, shredded', photo_path: '', description: '')
ChickenBreasts          = Ingredient.create(name: 'Chicken, Breasts',            photo_path: '', description: '')
Eggs                    = Ingredient.create(name: 'Eggs',                        photo_path: '', description: '')
FlourAllPurpose         = Ingredient.create(name: 'Flour, all-purpose',          photo_path: '', description: '')
OilOlive                = Ingredient.create(name: 'Oil, Olive',                  photo_path: '', description: '')
SpaghettiThin           = Ingredient.create(name: 'Spaghetti, thin',             photo_path: '', description: '')
TomatoSauce             = Ingredient.create(name: 'Tomato, sauce',               photo_path: '', description: '')
TomatoWhole             = Ingredient.create(name: 'Tomato, whole',               photo_path: '', description: '')

user_local.user_ingredients.new(ingredient: BreadCrumbsPanko,     quantity:  8, unit: cup  )
user_local.user_ingredients.new(ingredient: CheeseMozzarella,     quantity:  4, unit: cup  )
user_local.user_ingredients.new(ingredient: CheeseParmesanGrated, quantity: 32, unit: floz )
user_local.user_ingredients.new(ingredient: ChickenBreasts,       quantity:  5, unit: pound)
user_local.user_ingredients.new(ingredient: Eggs,                 quantity: 12, unit: none )
user_local.user_ingredients.new(ingredient: FlourAllPurpose,      quantity:  8, unit: cup  )
user_local.user_ingredients.new(ingredient: OilOlive,             quantity:  1, unit: quart)
user_local.save

SECONDS_PER_MINUTE = 60

recipe = Recipe.new(
  user: user_local,
  name: 'Salsa Chicken',
  photo_path: '',
  description: 'Chicken seasoned with taco seasoning and topped with salsa, then baked.',
  total_time: Time.at(45*SECONDS_PER_MINUTE)
  )

user_local.user_recipe_favorites.new(recipe: recipe)
user_local.save

user_local.user_recipe_reviews.new(recipe: recipe, stars: 5, title: 'Best salsa chicken!', comments: 'Very tasty and easy meal to make. I marinated the chicken with the package of taco seasoning and 2/3 cup of water so it would not come out so spicy. Worked great! Chicken did not dry out and the seasoning was just right!')
user_local.save

recipe = Recipe.new(
  user: user_local,
  name: 'Chicken Parmesan',
  photo_path: 'recipes/cparm_001.jpg',
  description: 'A classic Italian dish prepared with tomato sauce and mozzarella, with a few additions by Chef John. Sure to impress your friends and family!',
  total_time: Time.at(60*SECONDS_PER_MINUTE)
  )

recipe.recipe_ingredients.new(ingredient: Basil,                 quantity:  0.25,  unit: floz )
recipe.recipe_ingredients.new(ingredient: BreadCrumbsPanko,      quantity:  4.0,   unit: cup  )
recipe.recipe_ingredients.new(ingredient: CheeseMozzarella,      quantity:  0.25,  unit: cup  )
recipe.recipe_ingredients.new(ingredient: CheeseParmesanGrated,  quantity:  0.75,  unit: cup  )
recipe.recipe_ingredients.new(ingredient: CheeseProvoloneGrated, quantity:  0.5,   unit: cup  )
recipe.recipe_ingredients.new(ingredient: ChickenBreasts,        quantity:  2.0,   unit: pound)
recipe.recipe_ingredients.new(ingredient: Eggs,                  quantity:  2.0,   unit: none )
recipe.recipe_ingredients.new(ingredient: FlourAllPurpose,       quantity:  2.0,   unit: tbl  )
recipe.recipe_ingredients.new(ingredient: OilOlive,              quantity:  1.0,   unit: cup  )
recipe.recipe_ingredients.new(ingredient: OilOlive,              quantity:  1.0,   unit: tbl  )
recipe.recipe_ingredients.new(ingredient: TomatoSauce,           quantity:  4.0,   unit: floz )
recipe.save

step = 0
recipe.recipe_steps.new(step_number:  step += 1, description: 'Preheat an oven to 450 degrees F (230 degrees C).')
recipe.recipe_steps.new(step_number:  step += 1, description: 'Place chicken breasts between two sheets of heavy plastic (resealable freezer bags work well) on a solid, level surface. Firmly pound chicken with the smooth side of a meat mallet to a thickness of 1/2-inch. Season chicken thoroughly with salt and pepper.')
recipe.recipe_steps.new(step_number:  step += 1, description: 'Beat eggs in a shallow bowl and set aside.')
recipe.recipe_steps.new(step_number:  step += 1, description: 'Mix bread crumbs and 1/2 cup Parmesan in a separate bowl, set aside.')
recipe.recipe_steps.new(step_number:  step += 1, description: 'Place flour in a sifter or strainer; sprinkle over chicken breasts, evenly coating both sides.')
recipe.recipe_steps.new(step_number:  step += 1, description: 'Dip flour coated chicken breast in beaten eggs. Transfer breast to breadcrumb mixture, pressing the crumbs into both sides. Repeat for each breast. Set aside breaded chicken breasts for about 15 minutes.')
recipe.recipe_steps.new(step_number:  step += 1, description: 'Heat 1 cup olive oil in a large skillet on medium-high heat until it begins to shimmer. Cook chicken until golden, about 2 minutes on each side. The chicken will finish cooking in the oven.')
recipe.recipe_steps.new(step_number:  step += 1, description: 'Place chicken in a baking dish and top each breast with about 1/3 cup of tomato sauce. Layer each chicken breast with equal amounts of mozzarella cheese, fresh basil, and provolone cheese. Sprinkle 1 to 2 tablespoons of Parmesan cheese on top and drizzle with 1 tablespoon olive oil.')
recipe.recipe_steps.new(step_number:  step += 1, description: 'Bake in the preheated oven until cheese is browned and bubbly, and chicken breasts are no longer pink in the center, 15 to 20 minutes. An instant-read thermometer inserted into the center should read at least 165 degrees F (74 degrees C).')
recipe.save
