function showIngredients(e) {
  var show_detail = e.target.getAttribute('show-detail');
  if (show_detail == 0) {   // hide ingredients detail.
    $('#ingredients').html('');
  } else {                  // show ingredients detail.
    var recipe_id = parseInt(e.target.getAttribute('data-recipe-id'));
    $.get(`/recipes/${recipe_id}/recipe_ingredients.json`, function(data) {
      var ingredients = {}, units = {};

      // Gather up reference data.
      data.included.forEach(function(relation) {
        if (relation.type == 'ingredients') {
          ingredients[relation['id']] = relation.attributes['name'];
        } else if (relation.type == 'units') {
          units[relation['id']] = relation.attributes['name'];
        }
      });

      // Create data array for display.
      var recipe_ingredients = [];
      data.data.forEach(function(recipe_ingredient) {
        var ingredient_name = ingredients[recipe_ingredient.relationships.ingredient.data['id']];
        var quantity        = recipe_ingredient.attributes['quantity'];
        var units_name      = recipe_ingredient.attributes['unit-id'] == null ? '' : units[recipe_ingredient.attributes['unit-id']];
        recipe_ingredients.push({ingredient: ingredient_name, quantity: quantity, unit: units_name });
      });

      // Display data via Handlebars template.
      var template = Handlebars.compile(document.getElementById("ingredients-template").innerHTML);
      $('#ingredients').html(template(recipe_ingredients));
    });
  }
  e.target.setAttribute('show-detail', show_detail == 0 ? 1 : 0);  // flip the show_detail flag.
  e.preventDefault();
}

function showSteps(e) {
  var show_detail = e.target.getAttribute('show-detail');
  if (show_detail == 0) {   // hide steps detail.
    $('#steps').html('');
  } else {                  // show steps detail.
    var recipe_id = parseInt(e.target.getAttribute('data-recipe-id'));
    $.get(`/recipes/${recipe_id}/recipe_steps.json`, function(data) {
      // Create data array for display.
      var recipe_steps = [];
      data.data.forEach(function(recipe_step) {
        var step_number = recipe_step.attributes['step-number'];
        var description = recipe_step.attributes['description'];
        recipe_steps.push({step_number: step_number, description: description });
      });

      // Display data via Handlebars template.
      var template = Handlebars.compile(document.getElementById("steps-template").innerHTML);
      $('#steps').html(template(recipe_steps));
    });
  }
  e.target.setAttribute('show-detail', show_detail == 0 ? 1 : 0);  // flip the show_detail flag.
  e.preventDefault();
}
