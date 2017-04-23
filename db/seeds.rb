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

BreadCrumbsPanko     = Ingredient.create(name: 'Bread Crumbs, Panko'     )
CheeseMozzarella     = Ingredient.create(name: 'Cheese, Mozzarella'      )
CheeseParmesanGrated = Ingredient.create(name: 'Cheese, Parmesan, grated')
ChickenBreasts       = Ingredient.create(name: 'Chicken, Breasts'        )
Eggs                 = Ingredient.create(name: 'Eggs'                    )
FlourAllPurpose      = Ingredient.create(name: 'Flour, all-purpose'      )
OilOlive             = Ingredient.create(name: 'Oil, Olive'              )
SpaghettiThin        = Ingredient.create(name: 'Spaghetti, thin'         )
TomatoWhole          = Ingredient.create(name: 'Tomato, whole'           )

user_local.user_ingredients.new(ingredient: BreadCrumbsPanko,     quantity:  8, unit: cup  )
user_local.user_ingredients.new(ingredient: CheeseMozzarella,     quantity:  4, unit: cup  )
user_local.user_ingredients.new(ingredient: CheeseParmesanGrated, quantity: 32, unit: floz )
user_local.user_ingredients.new(ingredient: ChickenBreasts,       quantity:  5, unit: pound)
user_local.user_ingredients.new(ingredient: Eggs,                 quantity: 12, unit: none )
user_local.user_ingredients.new(ingredient: FlourAllPurpose,      quantity:  8, unit: cup  )
user_local.user_ingredients.new(ingredient: OilOlive,             quantity:  1, unit: quart)
user_local.save

SECONDS_IN_MINUTE = 60

recipe = Recipe.new(
  name: 'Chicken Parmesan',
  description: 'A classic Italian dish prepared with tomato sauce and mozzarella, with a few additions by Chef John. Sure to impress your friends and family!',
  total_time: Time.at(60*SECONDS_IN_MINUTE)
  )
