const INGREDIENT_TABLE = '#ingredientTable tbody';
const STEP_TABLE       = '#stepTable tbody';

class RecipeDetailData {
  constructor(templateId) {
    this.data = [];
    this.HTML = '';
    this._template = Handlebars.compile(document.getElementById(templateId).innerHTML);
  }

  get loaded() {
    return this.HTML.length > 0;
  }

  set loaded(val) {
    if (val == true) {
      this.HTML = this._template(this.data);
    } else {
      this.HTML = '';
    }
  }
}

class Recipe {
  constructor() {
    this.ingredients = new RecipeDetailData("ingredients-template");
    this.recipe      = new RecipeDetailData("recipe-template");
    this.reviews     = new RecipeDetailData("reviews-template");
    this.steps       = new RecipeDetailData("steps-template");
  }

  addIngredient(ingredientName, quantity, unitName) {
    this.ingredients.data.push({ingredient: ingredientName, quantity: quantity, unit: unitName});
  }

  get ingredientsHTML() {
    return this.ingredients.HTML;
  }

  get ingredientsLoaded() {
    return this.ingredients.loaded;
  }

  set ingredientsLoaded(val) {
    this.ingredients.loaded= val;
  }

  setRecipe(recipeData) {
    this.recipe.data.push(recipeData);
  }

  get HTML() {
    return this.recipe.HTML;
  }

  set loaded(val) {
    this.recipe.loaded= val;
  }

  addReview(stars, titleHeader, comments, recipeId, reviewId, authorId) {
    this.reviews.data.push({stars: stars, titleHeader: titleHeader, comments: comments, recipe_id: recipeId, review_id: reviewId, author_id: authorId});
  }

  get reviewsHTML() {
    return this.reviews.HTML;
  }

  get reviewsLoaded() {
    return this.reviews.loaded;
  }

  set reviewsLoaded(val) {
    this.reviews.loaded = val;
  }

  addStep(stepNumber, description) {
    this.steps.data.push({step_number: stepNumber, description: description});
  }

  get stepsHTML() {
    return this.steps.HTML;
  }

  get stepsLoaded() {
    return this.steps.loaded;
  }

  set stepsLoaded(val) {
    this.steps.loaded = val;
  }
}

var recipe = nil;

// Add a new recipe ingredient at the beginning of the list.
function addIngredient(e) {
  $(INGREDIENT_TABLE).prepend(newIngredient());
  e.preventDefault();
}

// Add a new recipe step after the clicked row.
function addStep(e, clickedRow) {
  $(STEP_TABLE).insertAfter(clickedRow);
  renumberSteps(clickedRow, 'add');
  e.preventDefault();
}

// Assemble the star review image.
function createStars(numStars) {
  var stars = '';
  if (numStars == 0) {
    stars = 'No reviews yet.';
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

// Fetch recipe ingredients from the server.
function loadIngredients(recipeId) {
  $.get(`/recipes/${recipeId}/recipe_ingredients.json`, function(data) {
    if (data.data.length == 0) {
      recipe.addIngredient('No ingredients yet.', '', '');
    } else {
      var ingredients = {}, units = {};
      loadReferenceData(data, ingredients, units);
      data.data.forEach(function(recipeIngredient) {
        var ingredientName = ingredients[recipeIngredient.relationships.ingredient.data.id],
            quantity       = recipeIngredient.attributes.quantity,
            unitName       = recipeIngredient.attributes['unit-id'] == null ? '' : units[recipeIngredient.attributes['unit-id']];
        recipe.addIngredient(ingredientName, quantity, unitName);
      });
    }
    recipe.ingredientsLoaded = true;
    $('#ingredients').html(recipe.ingredientsHTML);
  })
  .fail(function(jqXHR, textStatus, error) {
    console.log('ERROR: ' + error);
  });
}

// Get a recipe from the server.
function loadRecipe(direction) {
  var recipeData = {};
  $.get('/recipes/0.json', {direction: direction}, function(data) {
    var authorName = data.data.relationships.author.data.email,
        favorite   = '',
        photoPath  = data.data.attributes['photo-path'];

    recipe = new Recipe();
    recipeData.recipe_id   = data.data.id;
    recipeData.author_id   = data.data.relationships.author.data.id;
    recipeData.name        = data.data.attributes.name;
    recipeData.description = data.data.attributes.description;
    recipeData.total_time  = data.data.attributes['total-time'] + ' minutes';
    recipeData.stars       = createStars(parseInt(data.data.attributes['average-stars']));

    var thisUserId = $('body').data('userid');

    var userRecipeFavorites = data.data.relationships['user-recipe-favorites'].data;
    for (var i = 0; i < userRecipeFavorites.length; ++i) {
      if (userRecipeFavorites[i]['user-id'] == thisUserId) {
        favorite = 'checked';
        break;
      }
    }

    recipeData.image             = `<img src='/assets/${photoPath}' height='200' width='360' title="${recipeData.name}} photo">`;
    recipeData.favorite          = `<input type='checkbox' class='favorite' ${favorite}>Favorite`;
    recipeData.submitter         = `Submitted by <a href='/users/${recipeData.author_id}/recipes'>${authorName}}</a>`;
    recipeData.ingredientsHeader = `<a class="js-ingredients" data-recipe-id=${recipeData.recipe_id} data-show-detail="1" href="#">Ingredients</a>`;
    recipeData.stepsHeader       = `<a class="js-steps" data-recipe-id=${recipeData.recipe_id} data-show-detail="1" href="#">Steps</a>`;
    recipeData.reviewsHeader     = `<a class="js-reviews" data-recipe-id=${recipeData.recipe_id} data-show-detail="1" href="#">Reviews</a>`;

    recipe.setRecipe(recipeData);
    recipe.loaded = true;
    $('.recipe-detail').html(recipe.HTML);

    // Update the URL.
    if (history.pushState) {
      if (window.location.pathname != `/recipes/${recipeData.recipe_id}`) {
        var newurl = window.location.protocol + "//" + window.location.host + `/recipes/${recipeData.recipe_id}`;
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

// Extract reference tables from serializer data.
function loadReferenceData(data, ingredients, units) {
  data.included.forEach(function(relation) {
    switch(relation.type) {
      case 'ingredients':
        ingredients[relation.id] = relation.attributes.name;
        break;
      case 'units':
        units[relation.id] = relation.attributes.name;
        break;
      default:
        console.log("Error: unknown relation type.");
        break;
    }
  });
}

// Fetch recipe reviews from the server.
function loadReviews(recipeId) {
  $.get(`/recipes/${recipeId}/recipe_reviews.json`, function(data) {
    if (data.data.length == 0) {
      recipe.addReview('No reviews yet.', '', '');
    } else {
      data.data.forEach(function(recipeReview) {
        var authorId    = recipeReview.attributes['user-id'],
            comments    = recipeReview.attributes.comments,
            recipeId    = recipeReview.attributes['recipe-id'],
            reviewId    = recipeReview.id,
            stars       = createStars(parseInt(recipeReview.attributes.stars)),
            thisUserId  = $('body').data('userid'),
            title       = recipeReview.attributes.title,
            titleHeader = '';

        if (authorId == thisUserId) {
          titleHeader = `<a href="/recipes/${recipeId}/recipe_reviews/${reviewId}"><strong>${title}</strong></a>`;
        } else {
          titleHeader = `<a href="/recipes/${recipeId}/recipe_reviews/${reviewId}">${title}</a>`;
        }

        if (comments.length > 60) {
          comments = comments.substring(0, 57) + '...';
        }

        recipe.addReview(stars, titleHeader, comments, recipeId, reviewId, authorId);
      });
    }
    recipe.reviewsLoaded = true;
    $('#reviews').html(recipe.reviewsHTML);
  })
  .fail(function(jqXHR, textStatus, error) {
    console.log('ERROR: ' + error);
  });
}

// Fetch recipe steps from the server.
function loadSteps(recipeId) {
  $.get(`/recipes/${recipeId}/recipe_steps.json`, function(data) {
    if (data.data.length == 0) {
      recipe.addStep('No steps yet.', '', '');
    } else {
      data.data.forEach(function(recipeStep) {
        var stepNumber  = recipeStep.attributes['step-number'],
            description = recipeStep.attributes.description;
        recipe.addStep(stepNumber, description);
      });
    }
    recipe.stepsLoaded = true;
    $('#steps').html(recipe.stepsHTML);
  })
  .fail(function(jqXHR, textStatus, error) {
    console.log('ERROR: ' + error);
  });
}

// Navigate to another recipe ('next', 'prev', 'current').
function navigateRecipe(e, direction) {
  loadRecipe(direction);
  e.preventDefault();
}

// Creates and returns a new recipe ingredient row.
function newIngredient() {
  var newRow   = $('#ingredientClone').clone(true),
      newRowId = nextRowId($(INGREDIENT_TABLE)),
      newId    = `recipe_recipe_ingredients_attributes_${newRowId}_`,
      newName  = `recipe[recipe_ingredients_attributes][${newRowId}]`;

  // Modify the clone row's attributes to represent a new record.
  newRow.removeAttr('id');

  var inputElems  = newRow.find('input'),
      labelElems  = newRow.find('label'),
      selectElems = newRow.find('select');

  var selectElem = selectElems.eq(0);
  selectElem.attr('name', `${newName}[ingredient_id]`);
  selectElem.attr('id',   `${newId}ingredient_id`    );

  var labelElem = labelElems.eq(0);
  labelElem.attr('for', `${newId}quantity`);

  var inputElem = inputElems.eq(0);
  inputElem.attr('name',  `${newName}[quantity]`);
  inputElem.attr('id',    `${newId}quantity`    );
  inputElem.attr('value', '' );

  selectElem = selectElems.eq(1);
  labelElems.eq(1).attr ('for', `${newId}unit_id`);
  selectElem.attr('name', `${newName}[unit_id]`);
  selectElem.attr('id',   `${newId}unit_id`    );

  inputElem = inputElems.eq(1);
  inputElem.attr('name', `${newName}[_destroy]`);

  inputElem = inputElems.eq(2);
  inputElem.attr('name', `${newName}[_destroy]`);
  inputElem.attr('id',   `${newId}_destroy`    );

  selectElems.find('option').each(function() {
    $(this)[0].removeAttribute('selected');
  });

  return newRow;
}

// Creates and returns a new recipe step row.
function newStep() {
  var newRow   = $('#stepClone').clone(true),
      newRowId = $(STEP_TABLE).find('tr').length + 1,  // plus 1 is to account for hidden clone row.
      newId    = `recipe_recipe_steps_attributes_${newRowId}_`,
      newName  = `recipe[recipe_steps_attributes][${newRowId}]`;

  // Modify the clone row's attributes to represent a new record.
  newRow.removeAttr('id');

  var inputElems    = newRow.find('input'),
      labelElems    = newRow.find('label'),
      textareaElems = newRow.find('textarea');

  var labelElem = labelElems.eq(0);
  labelElem.attr('for', newId + 'step_number');

  var inputElem = inputElems.eq(0);
  inputElem.attr('name', newName + '[step_number]');
  inputElem.attr('id',   newId   + 'step_number'  );

  labelElem = labelElems.eq(1);
  labelElem.attr('for', newId + 'step_number'  );

  var textAreaElem = textAreaElems.eq(0);
  textareaElem.attr('name', newName + '[description]');
  textareaElem.attr('id',   newId   + 'description'  );
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

// Apply stepNumber value and text to the given element.
function setStepNumber(elem, stepNumber) {
  var stepNumberTd   = $(elem).find('td:first'),
      stepNumberElem = stepNumberTd.find('input');
  stepNumberTd.find('label').text(stepNumber + ')');
  stepNumberElem.val(stepNumber);
}

// Display recipe's ingredient list.
function showIngredients(e) {
  var showDetail = e.target.getAttribute('data-show-detail');
  if (showDetail == 0) {   // hide detail.
    $('#ingredients').html('');
  } else {                 // show detail.
    if (recipe.ingredientsLoaded) {
      $('#ingredients').html(recipe.ingredientsHTML);
    } else {
      var recipeId = e.target.getAttribute('data-recipe-id');
      loadIngredients(recipeId);
    }
  }
  e.target.setAttribute('data-show-detail', showDetail == 0 ? 1 : 0);  // flip the showDetail flag.
  e.preventDefault();
}

// Display recipe's review list.
function showReviews(e) {
  var showDetail = e.target.getAttribute('data-show-detail');
  if (showDetail == 0) {   // hide detail.
    $('#reviews').html('');
  } else {                 // show detail.
    if (recipe.reviewsLoaded) {
      $('#reviews').html(recipe.reviewsHTML);
    } else {
      var recipeId = e.target.getAttribute('data-recipe-id');
      loadReviews(recipeId);
    }
  }
  e.target.setAttribute('data-show-detail', showDetail == 0 ? 1 : 0);  // flip the showDetail flag.
  e.preventDefault();
}

// Display recipe's step list.
function showSteps(e) {
  var showDetail = e.target.getAttribute('data-show-detail');
  if (showDetail == 0) {   // hide detail.
    $('#steps').html('');
  } else {                  // show detail.
    if (recipe.stepsLoaded) {
      $('#step').html(recipe.stepsHTML);
    } else {
      var recipeId = e.target.getAttribute('data-recipe-id');
      loadSteps(recipeId);
    }
  }
  e.target.setAttribute('data-show-detail', showDetail == 0 ? 1 : 0);  // flip the showDetail flag.
  e.preventDefault();
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
