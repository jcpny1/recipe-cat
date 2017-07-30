const NoReviewsYet = 'No reviews yet.';

// Add a new recipe ingredient at the beginning of the list.
function addIngredient(e) {
  ingredientTable().prepend(newIngredient());
  e.preventDefault();
}

// Add a new recipe step after the clicked row.
function addStep(e, clickedRow) {
  newStep().insertAfter(clickedRow);
  renumberSteps(clickedRow, 'add');
  e.preventDefault();
}

// Assemble the star review image.
function createStars(numStars) {
  var stars = '';
  if (numStars == 0) {
    stars = NoReviewsYet;
  } else {
    for (let i = 0; i < numStars; ++i) {
      stars += '<img src="/assets/review_star.png" height="12" width="12" title="recipe stars">';
    }
  }
  return stars;
}

// Delete an entire recipe.
function deleteRecipe(e) {
  if (confirm('Are you sure?') == true) {
    var recipeId = e.target.parentElement.getAttribute('data-recipe-id');
    $.ajax({
      type: "DELETE",
      url: `/recipes/${recipeId}`,
    })
    .fail(function(jqXHR, textStatus, error) {
      console.log('ERROR: ' + error);
    });
  }
  e.preventDefault();
}

// Delete a detail row from the recipe show page.
function deleteRow(e, renumber) {
  if (confirm('Are you sure?') == true) {
    var clickedRow = $(e.target).parent().parent().parent();

    // Renumber subsequent rows, if requested.
    if (renumber == true) {
      renumberSteps(clickedRow, 'delete');
    }

    // Eliminate the deleted row.
    if (clickedRow.attr('id')) {
      clickedRow.hide();  // Hide the row and
      clickedRow.find('input:checkbox.js-destroyRecord').prop('checked', true);  // mark it for destruction.
    } else {
      clickedRow.remove(); // A new row doesn't have an id. Just delete it.
    }
  }
  e.preventDefault();
}

// Returns the <tbody> element of ingredientTable.
function ingredientTable() {
  return $('#ingredientTable tbody');
}

// Navigate to another recipe ('next', 'prev', 'current').
function navigateRecipe(e, direction) {
  requestRecipe(direction);
  e.preventDefault();
}

// Creates and returns a new recipe ingredient row.
function newIngredient() {
  var newRow   = $('#ingredientClone').clone(true),
      newRowId = nextRowId(ingredientTable()),
      newId   = `recipe_recipe_ingredients_attributes_${newRowId}_`,
      newName = `recipe[recipe_ingredients_attributes][${newRowId}]`;

  // Modify the clone row's attributes to represent a new record.
  newRow.removeAttr('id');

  var inputElems  = newRow.find('input'),
      labelElems  = newRow.find('label'),
      selectElems = newRow.find('select');

  selectElems.eq(0).attr('name', `${newName}[ingredient_id]`);
  selectElems.eq(0).attr('id',   `${newId}ingredient_id`    );

  labelElems.eq(0).attr('for',   `${newId}quantity`    );
  inputElems.eq(0).attr('name',  `${newName}[quantity]`);
  inputElems.eq(0).attr('id',    `${newId}quantity`    );
  inputElems.eq(0).attr('value', '' );

  labelElems.eq(1).attr ('for',  `${newId}unit_id`    );
  selectElems.eq(1).attr('name', `${newName}[unit_id]`);
  selectElems.eq(1).attr('id',   `${newId}unit_id`    );

  inputElems.eq(1).attr('name',  `${newName}[_destroy]`);
  inputElems.eq(2).attr('name',  `${newName}[_destroy]`);
  inputElems.eq(2).attr('id',    `${newId}_destroy`    );

  selectElems.find('option').each(function() {
    $(this)[0].removeAttribute('selected');
  });

  return newRow;
}

// Creates and returns a new recipe step row.
function newStep() {
  var newRow   = $('#stepClone').clone(true),
      newRowId   = stepTable().find('tr').length + 1,  // plus 1 is to account for hidden clone row.
      newId      = `recipe_recipe_steps_attributes_${newRowId}_`,
      newName    = `recipe[recipe_steps_attributes][${newRowId}]`;

  // Modify the clone row's attributes to represent a new record.
  newRow.removeAttr('id');

  var inputElems = newRow.find('input'),
      labelElems = newRow.find('label'),
      textareaElems = newRow.find('textarea');

  labelElems.eq(0).attr('for',   newId   + 'step_number'  );
  inputElems.eq(0).attr('name',  newName + '[step_number]');
  inputElems.eq(0).attr('id',    newId   + 'step_number'  );

  labelElems.eq(1).attr   ('for',  newId   + 'step_number'  );
  textareaElems.eq(0).attr('name', newName + '[description]');
  textareaElems.eq(0).attr('id',   newId   + 'description'  );
  textareaElems.text('');

  return newRow;
}

// Returns the largest nested attribute index in the table, plus 1.
function nextRowId(tableElem) {
  var largestId = 0;
  tableElem.find('tr').find('input:first').each(function() {
    var thisId = parseInt($(this).prop('id').match(/\d+/)[0]);
    if (thisId > largestId) {
      largestId = thisId;
    }
  });
  return largestId + 1;
}

// Beginning at the row after the clicked row, renumber the steps to account for the added or removed step.
function renumberSteps(clickedRow, action) {
  var stepNumber = parseInt(clickedRow.find('input[name*="step_number"]').val());
  clickedRow.nextAll('tr').each( function() {  // Tip: renumber only visible rows. Hidden rows are deleted rows.
    if ($(this).is(':visible')) {
      if (action == 'add') {
        stepNumber += 1;
        setStepNumber(this, stepNumber);
      } else {  // 'delete' action
        setStepNumber(this, stepNumber);
        stepNumber += 1;
      }
    }
  });
}

var recipeTemplate = nil;

// Get a recipe from the server.
function requestRecipe(direction) {
  $.get('/recipes/0.json', {direction: direction}, function(data) {
    var authorName = data.data.relationships.author.data.email,
        favorite   = '',
        photoPath  = data.data.attributes['photo-path'];

    var recipe = {};
    recipe.recipe_id     = data.data.id;
    recipe.author_id     = data.data.relationships.author.data.id;
    recipe.name          = data.data.attributes.name;
    recipe.description   = data.data.attributes.description;
    recipe.total_time    = data.data.attributes['total-time'] + ' minutes';
    recipe.stars         = createStars(parseInt(data.data.attributes['average-stars']));

    var thisUserId = $('body').data('userid');
    var userRecipeFavorites = data.data.relationships['user-recipe-favorites'].data;
    for (var i = 0; i < userRecipeFavorites.length; ++i) {
      if (userRecipeFavorites[i]['user-id'] == thisUserId) {
        favorite = 'checked';
        break;
      }
    }

    recipe.image             = `<img src='/assets/${photoPath}' height='200' width='360' title="${recipe.name}} photo">`;
    recipe.favorite          = `<input type='checkbox' class='favorite' ${favorite}>Favorite`;
    recipe.submitter         = `Submitted by <a href='/users/${recipe.author_id}/recipes'>${authorName}}</a>`;
    recipe.ingredientsHeader = `<a class="js-ingredients" data-recipe-id=${recipe.recipe_id} data-show-detail="1" href="#">Ingredients</a>`;
    recipe.stepsHeader       = `<a class="js-steps" data-recipe-id=${recipe.recipe_id} data-show-detail="1" href="#">Steps</a>`;
    recipe.reviewsHeader     = `<a class="js-reviews" data-recipe-id=${recipe.recipe_id} data-show-detail="1" href="#">Reviews</a>`;

    // Display data via Handlebars template.
    if (!recipeTemplate) {
      recipeTemplate = Handlebars.compile(document.getElementById("recipe-template").innerHTML);
    }
    $('.recipe-detail').html(recipeTemplate(recipe));

    if (history.pushState) {
      if (window.location.pathname != `/recipes/${recipe.recipe_id}`) {
        var newurl = window.location.protocol + "//" + window.location.host + `/recipes/${recipe.recipe_id}`;
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

// Apply stepNumber value and text to the given element.
function setStepNumber(elem, stepNumber) {
  var stepNumberTd   = $(elem).find('td:first'),
      stepNumberElem = stepNumberTd.find('input');
  stepNumberTd.find('label').text(stepNumber + ')');
  stepNumberElem.val(stepNumber);
}

var ingredientsTemplate = nil;

// Display recipe's ingredient list.
function showIngredients(e) {
  var showDetail = e.target.getAttribute('data-show-detail');
  if (showDetail == 0) {   // hide detail.
    $('#ingredients').html('');
  } else {                  // show detail.
    var recipeId = e.target.getAttribute('data-recipe-id');
    $.get(`/recipes/${recipeId}/recipe_ingredients.json`, function(data) {
      // Gather up reference data.
      var ingredients = {}, units = {};
      if (data.included) {
        data.included.forEach(function(relation) {
          if (relation.type == 'ingredients') {
            ingredients[relation.id] = relation.attributes.name;
          } else if (relation.type == 'units') {
            units[relation.id] = relation.attributes.name;
          }
        });
      }

      // Create data array for display.
      var recipeIngredients = [];
      data.data.forEach(function(recipeIngredient) {
        var ingredientName = ingredients[recipeIngredient.relationships.ingredient.data.id],
            quantity       = recipeIngredient.attributes.quantity,
            unitsName      = recipeIngredient.attributes['unit-id'] == null ? '' : units[recipeIngredient.attributes['unit-id']];
        recipeIngredients.push({ingredient: ingredientName, quantity: quantity, unit: unitsName});
      });

      // Show a message if there are no ingredients.
      if (recipeIngredients.length == 0) {
        recipeIngredients.push({ingredient: 'No ingredients yet.', quantity: '', unit: ''});
      }

      // Display data via Handlebars template.
      if (!ingredientsTemplate) {
        ingredientsTemplate = Handlebars.compile(document.getElementById("ingredients-template").innerHTML);
      }
      $('#ingredients').html(ingredientsTemplate(recipeIngredients));
    })
    .fail(function(jqXHR, textStatus, error) {
      console.log('ERROR: ' + error);
    });
  }
  e.target.setAttribute('data-show-detail', showDetail == 0 ? 1 : 0);  // flip the showDetail flag.
  e.preventDefault();
}

var reviewsTemplate = nil;

// Display recipe's review list.
function showReviews(e) {
  var showDetail = e.target.getAttribute('data-show-detail');
  if (showDetail == 0) {   // hide detail.
    $('#reviews').html('');
  } else {                  // show detail.
    var recipeId = e.target.getAttribute('data-recipe-id');
    $.get(`/recipes/${recipeId}/recipe_reviews.json`, function(data) {
      // Create data array for display.
      var recipeReviews = [];
      data.data.forEach(function(recipeReview) {
        var authorId = recipeReview.attributes['user-id'],
            comments = recipeReview.attributes.comments,
            recipeId = recipeReview.attributes['recipe-id'],
            reviewId = recipeReview.id,
            stars    = createStars(parseInt(recipeReview.attributes.stars)),
            thisUserId = $('body').data('userid'),
            title    = recipeReview.attributes.title,
            titleHeader = '';


        if (authorId == thisUserId) {
          titleHeader = `<a href="/recipes/${recipeId}/recipe_reviews/${reviewId}"><strong>${title}</strong></a>`;
        } else {
          titleHeader = `<a href="/recipes/${recipeId}/recipe_reviews/${reviewId}">${title}</a>`;
        }

        if (comments.length > 60) {
          comments = comments.substring(0, 57) + '...';
        }

        recipeReviews.push({stars: stars, titleHeader: titleHeader, comments: comments, recipe_id: recipeId, review_id: reviewId, author_id: authorId});
      });

      // Show a message if there are no reviews.
      if (recipeReviews.length == 0) {
        recipeReviews.push({stars: NoReviewsYet, titleHeader: '', comments: ''});
      }

      // Display data via Handlebars template.
      if (!reviewsTemplate) {
        reviewsTemplate = Handlebars.compile(document.getElementById("reviews-template").innerHTML);
      }
      $('#reviews').html(reviewsTemplate(recipeReviews));
    })
    .fail(function(jqXHR, textStatus, error) {
      console.log('ERROR: ' + error);
    });
  }
  e.target.setAttribute('data-show-detail', showDetail == 0 ? 1 : 0);  // flip the showDetail flag.
  e.preventDefault();
}

var stepsTemplate = nil;

// Display recipe's step list.
function showSteps(e) {
  var showDetail = e.target.getAttribute('data-show-detail');
  if (showDetail == 0) {   // hide detail.
    $('#steps').html('');
  } else {                  // show detail.
    var recipeId = e.target.getAttribute('data-recipe-id');
    $.get(`/recipes/${recipeId}/recipe_steps.json`, function(data) {
      // Create data array for display.
      var recipeSteps = [];
      data.data.forEach(function(recipeStep) {
        var stepNumber  = recipeStep.attributes['step-number'],
            description = recipeStep.attributes.description;
        recipeSteps.push({step_number: stepNumber, description: description});
      });

      // Show a message if there are no steps.
      if (recipeSteps.length == 0) {
        recipeSteps.push({step_number: 'No steps yet.', description: ''});
      }

      // Display data via Handlebars template.
      if (!stepsTemplate) {
        stepsTemplate = Handlebars.compile(document.getElementById("steps-template").innerHTML);
      }
      $('#steps').html(stepsTemplate(recipeSteps));
    })
    .fail(function(jqXHR, textStatus, error) {
      console.log('ERROR: ' + error);
    });
  }
  e.target.setAttribute('data-show-detail', showDetail == 0 ? 1 : 0);  // flip the showDetail flag.
  e.preventDefault();
}

// Returns the <tbody> element of stepTable.
function stepTable() {
  return $('#stepTable tbody');
}

function toggleFavorite(elem) {
  var recipeId = elem.dataset.recipeId,
      userId   = elem.dataset.userId;
  $.ajax({
    type: "PATCH",
    url: `/users/${userId}/user_recipe_favorites/${recipeId}`,
    data: {'favorite': elem.checked},
    dataType: 'json'
  });
}
