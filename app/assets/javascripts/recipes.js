function addIngredient(e) {
  var ingredientTable = $('#ingredientTable tbody'),
      newRow   = ingredientTable.find('tr:first').clone(),
      newRowId = ingredientTable.find('tr').length,
      newId   = `recipe_recipe_ingredients_attributes_${newRowId}_`,
      newName = `recipe[recipe_ingredients_attributes][${newRowId}]`;

  // These are the attributes that need to be edited when cloning a table row.
  // The index values need updating to a new, unique, value -
  //   "recipe[recipe_ingredients_attributes][0][ingredient_id]"
  //   "recipe_recipe_ingredients_attributes_0_ingredient_id"
  // and existing values need to be cleared out -
  //   data-recipe-ingredient-id="16"
  //   selected="selected"
  //   value='4'

  newRow.attr('id', 'recipe-ingredient-id-');

  var selectElems = newRow.find('select');
  selectElems.eq(0).attr('name', newName + '[ingredient_id]');
  selectElems.eq(0).attr('id',   newId   + 'ingredient_id'  );

  var labelElems = newRow.find('label'),
      inputElems = newRow.find('input');
  labelElems.eq(0).attr('for',   newId   + 'quantity'  );
  inputElems.eq(0).attr('name',  newName + '[quantity]');
  inputElems.eq(0).attr('id',    newId   + 'quantity'  );
  inputElems.eq(0).attr('value', '' );

  labelElems.eq(1).attr ('for',  newId   + 'unit_id'  );
  selectElems.eq(1).attr('name', newName + '[unit_id]');
  selectElems.eq(1).attr('id', newId + 'unit_id' );

  newRow.find('a.js-deleteIngredient').eq(0).attr('data-recipe-ingredient-id', '');
  newRow.find('a.js-deleteIngredient').eq(0).click(deleteIngredient);

  selectElems.find('option').each(function(i, e) {
    e.removeAttribute('selected');
  });

  ingredientTable.prepend(newRow);
  e.preventDefault();
}

function addStep(e) {
  var stepTable  = $('#stepTable tbody'),
      newRow     = stepTable.find('tr:first').clone(),
      newRowId   = stepTable.find('tr').length,
      newId      = `recipe_recipe_steps_attributes_${newRowId}_`,
      newName    = `recipe[recipe_steps_attributes][${newRowId}]`,
      clickedRow = $(e.target).parent().parent().parent(),
      stepNumber = parseInt(clickedRow.find('input[name*="step_number"]').val());

  // These are the attributes that need to be edited when cloning a table row.
  // The index and name values need updating:
  //   <tr id="recipe-step-id-11">
  //   "recipe[recipe_steps_attributes][0][step_id]"
  //   "recipe_recipe_steps_attributes_0_step_id"
  // and existing values need to be cleared out:
  //   data-recipe-step-id="16"
  //   $('textarea#...').text()
  //   value='4'

  newRow.removeAttr('id');

  var inputElems = newRow.find('input'),
      labelElems = newRow.find('label');
  labelElems.eq(0).attr('for',   newId   + 'step_number'  );
  inputElems.eq(0).attr('name',  newName + '[step_number]');
  inputElems.eq(0).attr('id',    newId   + 'step_number'  );
  inputElems.eq(0).attr('value', stepNumber);

  var textareaElems = newRow.find('textarea');
  labelElems.eq(1).attr   ('for',  newId   + 'step_number'  );
  textareaElems.eq(0).attr('name', newName + '[description]');
  textareaElems.eq(0).attr('id',   newId   + 'description'  );
  textareaElems.text('');

  newRow.find('a.js-deleteStep').eq(0).attr('data-recipe-step-id', '');
  newRow.find('a.js-deleteStep').eq(0).click(deleteStep);

  newRow.insertAfter(clickedRow);

  clickedRow.nextAll('tr').each( function() {
    var stepNumberTd = $(this).find('td:first'),
        stepNumberElem = stepNumberTd.find('input'),
        stepNumber = parseInt(stepNumberElem.val()) + 1;
    stepNumberElem.val(stepNumber);
    stepNumberTd.find('label').text('Step ' + stepNumber);
  });
  e.preventDefault();
}

//  Delete a recipe ingredient from the recipe.
function deleteIngredient(e) {
  if (confirm('Are you sure?') == true) {
    $(e.target).parent().parent().parent().hide();  // Hide the entire recipe step <tr>.
    var recipe_ingredient_id = $(e.target).parent().data('recipeIngredientId');
    $("tr#recipe-ingredient-id-" + recipe_ingredient_id + " input:checkbox.js-destroyIngredient").prop('checked', true);
  }
  e.preventDefault();
}

//  Delete an entire recipe.
function deleteRecipe(e) {
  if (confirm('Are you sure?') == true) {
    var recipe_id = e.target.parentElement.getAttribute('data-recipe-id');
    $.ajax({
      type: "DELETE",
      url: `/recipes/${recipe_id}`,
    })
    .fail(function(jqXHR, textStatus, error) {
      console.log('ERROR: ' + error);
    });
  }
  e.preventDefault();
}

//  Delete a recipe step from the recipe.
function deleteStep(e) {
  if (confirm('Are you sure?') == true) {
    $(e.target).parent().parent().parent().hide();  // Hide the entire recipe step <tr>.
    var recipe_step_id = $(e.target).parent().data('recipeStepId');
    $("tr#recipe-step-id-" + recipe_step_id + " input:checkbox.js-destroyStep").prop('checked', true);
  }
  e.preventDefault();
}

// Navigate to another recipe ('next', 'prev', 'current').
function navigateRecipe(e, direction) {
  requestRecipe(direction);
  e.preventDefault();
}

var recipeTemplate = nil;

// Get a recipe from the server.
function requestRecipe(direction) {
  $.get('/recipes/0.json', {direction: direction}, function(data) {

    var author_name = data.data.relationships.author.data['email'],
        favorite    = '',
        photo_path  = data.data.attributes['photo-path'];


    var recipe = {};
    recipe['recipe_id']   = data.data['id'];
    recipe['author_id']   = data.data.relationships.author.data['id'];
    recipe['name']        = data.data.attributes['name'];
    recipe['description'] = data.data.attributes['description'];
    recipe['total_time']  = data.data.attributes['total-time'] + ' minutes';

    var this_user_id = $('body').data('userid');
    var user_recipe_favorites = data.data.relationships['user-recipe-favorites']['data'];
    for (var i = 0; i < user_recipe_favorites.length; ++i) {
      if (user_recipe_favorites[i]['user-id'] == this_user_id) {
        favorite = 'checked';
        break;
      }
    }

    recipe['image'] = `<img src='/assets/${photo_path}' height='200' width='360' title="${recipe['name']}} photo">`;
    recipe['favorite'] = `<input type='checkbox' class='favorite' ${favorite}>Favorite`;
    recipe['submitter'] = `Submitted by <a href='/users/${recipe['author_id']}/recipes'>${author_name}}</a>`;
    recipe['ingredientsHeader'] = `<a class="js-ingredients" data-recipe-id=${recipe['recipe_id']} data-show-detail="1" href="#">Ingredients</a>`;
    recipe['stepsHeader'] = `<a class="js-steps" data-recipe-id=${recipe['recipe_id']} data-show-detail="1" href="#">Steps</a>`;
    recipe['reviewsHeader'] = `<a class="js-reviews" data-recipe-id=${recipe['recipe_id']} data-show-detail="1" href="#">Reviews</a>`;

    // Display data via Handlebars template.
    if (!recipeTemplate) {
      recipeTemplate = Handlebars.compile(document.getElementById("recipe-template").innerHTML);
    }
    $('.recipe-detail').html(recipeTemplate(recipe));

    if (history.pushState) {
      if (window.location.pathname != `/recipes/${recipe['recipe_id']}`) {
        var newurl = window.location.protocol + "//" + window.location.host + `/recipes/${recipe['recipe_id']}`;
        window.history.pushState({path:newurl}, '', newurl);
      }
    }

    $('.js-deleteRecipe').eq(0).click(function(e) { deleteRecipe(e); });
    $('.js-ingredients').eq(0).click(function(e)  { showIngredients(e); });
    $('.js-steps').eq(0).click(function(e) { showSteps(e); });
    $('.js-reviews').eq(0).click(function(e) { showReviews(e); });
  })
  .fail(function(jqXHR, textStatus, error) {
    console.log('ERROR: ' + error);
  });
}

// Display recipe's ingredient list.
function showIngredients(e) {
  var show_detail = e.target.getAttribute('data-show-detail');
  if (show_detail == 0) {   // hide detail.
    $('#ingredients').html('');
  } else {                  // show detail.
    var recipe_id = e.target.getAttribute('data-recipe-id');
    $.get(`/recipes/${recipe_id}/recipe_ingredients.json`, function(data) {
      // Gather up reference data.
      var ingredients = {}, units = {};
      if (data.included) {
        data.included.forEach(function(relation) {
          if (relation.type == 'ingredients') {
            ingredients[relation['id']] = relation.attributes['name'];
          } else if (relation.type == 'units') {
            units[relation['id']] = relation.attributes['name'];
          }
        });
      }

      // Create data array for display.
      var recipe_ingredients = [];
      data.data.forEach(function(recipe_ingredient) {
        var ingredient_name = ingredients[recipe_ingredient.relationships.ingredient.data['id']],
            quantity        = recipe_ingredient.attributes['quantity'],
            units_name      = recipe_ingredient.attributes['unit-id'] == null ? '' : units[recipe_ingredient.attributes['unit-id']];
        recipe_ingredients.push({ingredient: ingredient_name, quantity: quantity, unit: units_name});
      });

      // Show a message if there are no ingredients.
      if (recipe_ingredients.length == 0) {
        recipe_ingredients.push({ingredient: 'No ingredients yet.', quantity: '', unit: ''});
      }

      // Display data via Handlebars template.
      var template = Handlebars.compile(document.getElementById("ingredients-template").innerHTML);
      $('#ingredients').html(template(recipe_ingredients));
    })
    .fail(function(jqXHR, textStatus, error) {
      console.log('ERROR: ' + error);
    });
  }
  e.target.setAttribute('data-show-detail', show_detail == 0 ? 1 : 0);  // flip the show_detail flag.
  e.preventDefault();
}

// Display a recipe.
function showRecipe(e) {
  var recipe_id = e.target.parentElement.getAttribute('data-recipe-id');
  var recipe    = requestRecipe(recipe_id, '');
}

// Display recipe's review list.
function showReviews(e) {
  var show_detail = e.target.getAttribute('data-show-detail');
  if (show_detail == 0) {   // hide detail.
    $('#reviews').html('');
  } else {                  // show detail.
    var recipe_id = e.target.getAttribute('data-recipe-id');
    $.get(`/recipes/${recipe_id}/recipe_reviews.json`, function(data) {
      // Create data array for display.
      var recipe_reviews = [];
      data.data.forEach(function(recipe_review) {

        var comments  = recipe_review['comments'],
            num_stars = parseInt(recipe_review['stars']),
            recipe_id = recipe_review['recipe_id'],
            review_id = recipe_review['id'],
            title     = recipe_review['title'];

        var stars = '';
        for (var i = 0; i < num_stars; ++i) {
          stars += '<img src="/assets/review_star.png" height="12" width="12" title="recipe stars">';
        }

        var titleHeader = `<a href="/recipes/${recipe_id}/recipe_reviews/${review_id}">${title}</a>`;

        if (comments.length > 60) {
          comments = comments.substring(0, 57) + '...';
        }

        recipe_reviews.push({stars: stars, titleHeader: titleHeader, comments: comments});
      });

      // Show a message if there are no reviews.
      if (recipe_reviews.length == 0) {
        recipe_reviews.push({stars: 'No reviews yet.', titleHeader: '', comments: ''});
      }

      // Display data via Handlebars template.
      var template = Handlebars.compile(document.getElementById("reviews-template").innerHTML);
      $('#reviews').html(template(recipe_reviews));
    })
    .fail(function(jqXHR, textStatus, error) {
      console.log('ERROR: ' + error);
    });
  }
  e.target.setAttribute('data-show-detail', show_detail == 0 ? 1 : 0);  // flip the show_detail flag.
  e.preventDefault();
}

// Display recipe's step list.
function showSteps(e) {
  var show_detail = e.target.getAttribute('data-show-detail');
  if (show_detail == 0) {   // hide detail.
    $('#steps').html('');
  } else {                  // show detail.
    var recipe_id = e.target.getAttribute('data-recipe-id');
    $.get(`/recipes/${recipe_id}/recipe_steps.json`, function(data) {
      // Create data array for display.
      var recipe_steps = [];
      data.data.forEach(function(recipe_step) {
        var step_number = recipe_step.attributes['step-number'],
            description = recipe_step.attributes['description'];
        recipe_steps.push({step_number: step_number, description: description});
      });

      // Show a message if there are no steps.
      if (recipe_steps.length == 0) {
        recipe_steps.push({step_number: 'No steps yet.', description: ''});
      }

      // Display data via Handlebars template.
      var template = Handlebars.compile(document.getElementById("steps-template").innerHTML);
      $('#steps').html(template(recipe_steps));
    })
    .fail(function(jqXHR, textStatus, error) {
      console.log('ERROR: ' + error);
    });
  }
  e.target.setAttribute('data-show-detail', show_detail == 0 ? 1 : 0);  // flip the show_detail flag.
  e.preventDefault();
}

function toggleFavorite(elem) {
  var recipe_id = elem.dataset.recipeId,
      user_id   = elem.dataset.userId;
  $.ajax({
    type: "PATCH",
    url: `/users/${user_id}/user_recipe_favorites/${recipe_id}`,
    data: {'favorite': elem.checked},
    dataType: 'json'
  });
}
