function addIngredient(e) {
  var ingredientTable = $('#ingredientTable tbody');
  var newRow   = ingredientTable.find('tr:first').clone();
  var newRowId = ingredientTable.find('tr').length;
  var newId   = `recipe_recipe_ingredients_attributes_${newRowId}_`;
  var newName = `recipe[recipe_ingredients_attributes][${newRowId}]`;

  // These are the attributes that need to be edited when cloning a table row.
  // The index values need updating to a new, unique, value -
  //   "recipe[recipe_ingredients_attributes][0][ingredient_id]"
  //   "recipe_recipe_ingredients_attributes_0_ingredient_id"
  // and existing values need to be cleared out -
  //   data-recipe-ingredient-id="16"
  //   selected="selected"
  //   value='4'

  newRow[0].setAttribute('id', 'recipe-ingredient-id-');

  var selectElems = newRow.find('select');
  selectElems[0].setAttribute('name', newName + '[ingredient_id]');
  selectElems[0].setAttribute('id',   newId   + 'ingredient_id'  );

  var inputElems = newRow.find('input');
  inputElems[0].setAttribute('name', newName + '[new_ingredient]');
  inputElems[0].setAttribute('id',   newId   + 'new_ingredient'  );

  var labelElems = newRow.find('label');
  labelElems[0].setAttribute('for',   newId   + 'quantity'  );
  inputElems[1].setAttribute('name',  newName + '[quantity]');
  inputElems[1].setAttribute('id',    newId   + 'quantity'  );
  inputElems[1].setAttribute('value', '' );

  labelElems[1].setAttribute ('for',  newId   + 'unit_id'  );
  selectElems[1].setAttribute('name', newName + '[unit_id]');
  selectElems[1].setAttribute('id',   newId   + 'unit_id'  );

  newRow.find('a.js-deleteIngredient')[0].setAttribute('data-recipe-ingredient-id', '');
  newRow.find('a.js-deleteIngredient')[0].addEventListener('click', deleteIngredient, false);

  selectElems.find('option').each(function(i, e) {
    e.removeAttribute('selected');
  });

  ingredientTable.append(newRow);
console.log(ingredientTable.html());
  e.preventDefault();
}

function addStep(e) {
  var stepTable = $('#stepTable tbody');
  var newRow    = stepTable.find('tr:first').clone();
  var newRowId  = stepTable.find('tr').length;
  var newId   = `recipe_recipe_steps_attributes_${newRowId}_`;
  var newName = `recipe[recipe_steps_attributes][${newRowId}]`;
  var newStepNumber = 0;

  Array.from(stepTable.find('label + input')).forEach(function(e) {
    thisStepNumber = parseInt(e.value);
    if (thisStepNumber > newStepNumber) {
      newStepNumber = thisStepNumber;
    }
  });
  ++newStepNumber;

  // These are the attributes that need to be edited when cloning a table row.
  // The index and name values need updating:
  //   <tr id="recipe-step-id-11">
  //   "recipe[recipe_steps_attributes][0][step_id]"
  //   "recipe_recipe_steps_attributes_0_step_id"
  // and existing values need to be cleared out:
  //   data-recipe-step-id="16"
  //   $('textarea#...').text()
  //   value='4'

  newRow[0].removeAttribute('id');

  var inputElems = newRow.find('input');
  var labelElems = newRow.find('label');
  labelElems[0].setAttribute('for',   newId   + 'step_number'  );
  inputElems[0].setAttribute('name',  newName + '[step_number]');
  inputElems[0].setAttribute('id',    newId   + 'step_number'  );
  inputElems[0].setAttribute('value', newStepNumber);

  var textareaElems = newRow.find('textarea');
  labelElems[1].setAttribute   ('for',  newId   + 'step_number'  );
  textareaElems[0].setAttribute('name', newName + '[description]');
  textareaElems[0].setAttribute('id',   newId   + 'description'  );
  textareaElems.text('');

  newRow.find('a.js-deleteStep')[0].setAttribute('data-recipe-step-id', '');
  newRow.find('a.js-deleteStep')[0].addEventListener('click', deleteStep, false);

  stepTable.append(newRow);
  e.preventDefault();
}

//  Delete a recipe ingredient from the recipe.
function deleteIngredient(e) {
  if (confirm('Are you sure?') == true) {
    // Hide the entire recipe step <tr>.
    $(e.target).parent().parent().parent().hide();
    // Mark the row for deletion by backend.
    var recipe_ingredient_id = $(e.target).parent().data('recipeIngredientId');
    if (!isNaN(recipe_ingredient_id)) {
      var deleted_recipe_ingredient_id = recipe_ingredient_id < 0 ? recipe_ingredient_id : -recipe_ingredient_id;
      $("tr#recipe-ingredient-id-" + recipe_ingredient_id + " + input:hidden").attr('value', deleted_recipe_ingredient_id);
    }
  }
  e.preventDefault();
}

//  Delete a recipe ingredient from the recipe.
function deleteStep(e) {
  if (confirm('Are you sure?') == true) {
    // Hide the entire recipe step <tr>.
    $(e.target).parent().parent().parent().hide();
    // Mark the row for deletion by backend.
    var recipe_step_id = $(e.target).parent().data('recipeStepId');
    if (!isNaN(recipe_step_id)) {
      var deleted_recipe_step_id = recipe_step_id < 0 ? recipe_step_id : -recipe_step_id;
      $("tr#recipe-step-id-" + recipe_step_id + " + input:hidden").attr('value', deleted_recipe_step_id);
    }
  }
  e.preventDefault();
}

// Display recipe's ingredient list.
function showIngredients(e) {
  var show_detail = e.target.getAttribute('show-detail');
  if (show_detail == 0) {   // hide ingredients detail.
    $('#ingredients').html('');
  } else {                  // show ingredients detail.
    var recipe_id = e.target.getAttribute('data-recipe-id');
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

// Display recipe's step list.
function showSteps(e) {
  var show_detail = e.target.getAttribute('show-detail');
  if (show_detail == 0) {   // hide steps detail.
    $('#steps').html('');
  } else {                  // show steps detail.
    var recipe_id = e.target.getAttribute('data-recipe-id');
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
