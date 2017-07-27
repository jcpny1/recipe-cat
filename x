diff --git a/app/assets/javascripts/recipes.js b/app/assets/javascripts/recipes.js
index bba5872..b9048b5 100644
--- a/app/assets/javascripts/recipes.js
+++ b/app/assets/javascripts/recipes.js
@@ -122,47 +122,64 @@ function deleteStep(e) {
   e.preventDefault();
 }
 
-var recipeTemplate = nil;
-
 // Navigate to next recipe.
 function navigateRecipe(e, direction) {
-  var recipe_id = $('.js-currRecipe').val();
-  // Create data array for display.
-
-// data.data.attributes['user-id']
-// Object { user-id: 4, name: "Duck Fesenjan", photo-path: "recipes/duck fesenjan.jpg", description: "Chef John's take on the classic Per…", total-time: 210 }
-
-// data.data.relationships['author'].data
-// Object { id: 4, email: "joe_user@aol.com", created_at: "2017-07-24T16:43:30.416Z", updated_at: "2017-07-24T16:43:30.416Z", provider: null, uid: null, role: "user" }
-  var recipe = {};
-
-  $.get(`/recipes/${recipe_id}/navigate.json`, {direction: direction}, function(data) {
-// var ingredient_name = ingredients[recipe_ingredient.relationships.ingredient.data['id']];
-// var quantity        = recipe_ingredient.attributes['quantity'];
-    recipe['author_id']   = data.data.relationships.author.data['id'];
-    recipe['author_name'] = data.data.relationships.author.data['email'];
-    recipe['recipe_id']   = data.data['id'];
-    recipe['photo_path']  = data.data.attributes['photo-path'];
-    recipe['name']        = data.data.attributes['name'];
-    recipe['description'] = data.data.attributes['description'];
-    recipe['total_time']  = data.data.attributes['total-time'] + ' minutes';
-
-    $('.js-currRecipe').val(data.data['id']);
-  })
-  .done(function() {
+  e.preventDefault();
+  var recipe = requestRecipe(direction);
+}
+
+var recipeTemplate = nil;
+
+// Get a recipe from the server.
+function requestRecipe(direction) {
+  $.get('/recipes/0.json', {direction: direction}, function(data) {
+console.log(data);
+    var recipe = {};
+    recipe['author_id']      = data.data.relationships.author.data['id'];
+    recipe['author_name']    = data.data.relationships.author.data['email'];
+    recipe['recipe_id']      = data.data['id'];
+    recipe['photo_path']     = data.data.attributes['photo-path'];
+    recipe['name']           = data.data.attributes['name'];
+    recipe['description']    = data.data.attributes['description'];
+    recipe['total_time']     = data.data.attributes['total-time'] + ' minutes';
+    recipe['numIngredients'] = data.data.relationships['recipe-ingredients']['data'].length;
+    recipe['numSteps']       = data.data.relationships['recipe-steps']['data'].length;
+    recipe['numReviews']     = data.data.relationships['recipe-reviews']['data'].length;
+    recipe['favorite']       = '';
+
+    var this_user_id = $('body').data('userid');
+    var user_recipe_favorites = data.data.relationships['user-recipe-favorites']['data'];
+    for (var i = 0; i < user_recipe_favorites.length; ++i) {
+      if (user_recipe_favorites[i]['user-id'] == this_user_id) {
+        recipe['favorite'] = 'checked';
+        break;
+      }
+    }
     // Display data via Handlebars template.
     if (!recipeTemplate) {
       recipeTemplate = Handlebars.compile(document.getElementById("recipe-template").innerHTML);
     }
     $('.recipe-detail').html(recipeTemplate(recipe));
-    $('.js-deleteRecipe').eq(0).click(deleteRecipe);
+
+    $('.js-deleteRecipe').eq(0).click(function() {
+      deleteRecipe();
+    });
   })
-  .fail(function() {
+  .fail(function(jqXHR, textStatus, error) {
     console.log('error');
-  })
-  .always(function() {
   });
-  e.preventDefault();
+  return recipe;
+}
+
+// Save a recipe_id for later use.
+function saveRecipeId(recipe_id) {
+  // $.post(`/recipes/save_id/${recipe_id}`, function(data) {
+  // })
+  // .fail(function() {
+  //   console.log('error');
+  // });
+  // return recipe;
+console.log("nothin");
 }
 
 // Display recipe's ingredient list.
@@ -202,6 +219,12 @@ function showIngredients(e) {
   e.preventDefault();
 }
 
+// Display a recipe.
+function showRecipe(e) {
+  var recipe_id = e.target.parentElement.getAttribute('data-recipe-id');
+  var recipe    = requestRecipe(recipe_id, '');
+}
+
 // Display recipe's step list.
 function showSteps(e) {
   var show_detail = e.target.getAttribute('show-detail');
diff --git a/app/controllers/recipes_controller.rb b/app/controllers/recipes_controller.rb
index 4f582da..b0a44af 100644
--- a/app/controllers/recipes_controller.rb
+++ b/app/controllers/recipes_controller.rb
@@ -1,7 +1,7 @@
 # Rails controller for Recipe model.
 class RecipesController < ApplicationController
-  skip_after_action :verify_authorized,    only: :updated_after
-  after_action      :verify_policy_scoped, only: :updated_after
+  skip_after_action :verify_authorized,    only: [:updated_after, :save_id]
+  after_action      :verify_policy_scoped, only: [:updated_after]
 
   # save the selected ingredient filter value(s) for later display use.
   def filter
@@ -10,24 +10,12 @@ class RecipesController < ApplicationController
     redirect_to request.referer
   end
 
-  # Return the recipe corresonding to the previous or next id in the session[:recipe_id_list].
-  def navigate
+  # save the given recipe_id for future use.
+  def save_id
     skip_authorization
-    current_recipe_id = params[:id].to_i
-    current_recipe_index = session[:recipe_id_list].find_index(current_recipe_id)
-    if current_recipe_index
-      direction = params[:direction]
-      if (direction == 'next') && (current_recipe_index < session[:recipe_id_list].length - 1)
-        current_recipe_id = session[:recipe_id_list][current_recipe_index + 1]
-      elsif (direction == 'prev') && (current_recipe_index > 0)
-        current_recipe_id = session[:recipe_id_list][current_recipe_index - 1]
-      end
-    end
-    @recipe = Recipe.find(current_recipe_id)
-    respond_to do |format|
-      format.html { render @recipe }
-      format.json { render json: @recipe }
-    end
+    session[:recipe_id] = params[:id]
+binding.pry
+    render :nothing => true
   end
 
   # display recipes created or updated after the specified date.
@@ -54,8 +42,30 @@ class RecipesController < ApplicationController
 
   # display a specific recipe.
   def show
-    @recipe = Recipe.find_by(id: params[:id])
+    recipe_id = params[:id]
+    if recipe_id == "0"
+      recipe_id = session[:recipe_id].to_i
+      recipe_id = session[:recipe_id_list][0] if recipe_id == 0
+      recipe_index = session[:recipe_id_list].find_index(recipe_id)
+      if recipe_index
+        direction = params[:direction]
+        if (direction == 'next') && (recipe_index < session[:recipe_id_list].length - 1)
+          recipe_id = session[:recipe_id_list][recipe_index + 1]
+        elsif (direction == 'prev') && (recipe_index > 0)
+          recipe_id = session[:recipe_id_list][recipe_index - 1]
+        end
+      end
+    end
+
+    session[:recipe_id] = recipe_id
+
+    @recipe = Recipe.find_by(id: recipe_id)
     authorize @recipe
+
+    respond_to do |format|
+      format.html { render :show }
+      format.json { render json: @recipe }
+    end
   end
 
   # prepare to create a new recipe.
diff --git a/app/serializers/recipe_serializer.rb b/app/serializers/recipe_serializer.rb
index ae8b0cf..26afa6d 100644
--- a/app/serializers/recipe_serializer.rb
+++ b/app/serializers/recipe_serializer.rb
@@ -1,4 +1,8 @@
 class RecipeSerializer < ActiveModel::Serializer
   attributes :id, :user_id, :name, :photo_path, :description, :total_time
   has_one :author
+  has_many :recipe_ingredients
+  has_many :recipe_steps
+  has_many :recipe_reviews
+  has_many :user_recipe_favorites
 end
diff --git a/app/views/recipes/_recipes.html.erb b/app/views/recipes/_recipes.html.erb
index 3c8814b..78d0cb8 100644
--- a/app/views/recipes/_recipes.html.erb
+++ b/app/views/recipes/_recipes.html.erb
@@ -6,7 +6,7 @@
       <%= link_to recipe.name, recipe %>
     </div>
     <div class="col-sm-2">
-      <%= link_to image_tag(recipe.photo_path, size: "190x100", alt: "#{recipe.name} photo", title: 'recipe photo' ), recipe %>
+      <a class="js-selectRecipe" href="/recipes/<%=recipe.id%>" data-recipe-id="<%=recipe.id%>"><img src="/assets/<%=recipe.photo_path%>" height="100" width="190" title="<%=recipe.name%> photo"></a>
     </div>
     <div class="col-sm-1">
       <%= link_to pluralize(recipe.number_of_reviews, 'review'), recipe_recipe_reviews_path(recipe) %><br>
diff --git a/app/views/recipes/index.html.erb b/app/views/recipes/index.html.erb
index 354db9d..69f52b6 100644
--- a/app/views/recipes/index.html.erb
+++ b/app/views/recipes/index.html.erb
@@ -6,3 +6,12 @@
   </h2>
   <%= render partial: "recipes/recipes", locals: {recipes: @recipes} %>
 </div>
+
+<script type='text/javascript' charset='utf-8'>
+$(function () {
+  $('.js-selectRecipe').on('click', function(e) {
+    var recipe_id = e.target.parentElement.getAttribute('data-recipe-id');
+    saveRecipeId(recipe_id);
+  });
+});
+</script>
diff --git a/app/views/recipes/show.html.erb b/app/views/recipes/show.html.erb
index 7363c19..64be626 100644
--- a/app/views/recipes/show.html.erb
+++ b/app/views/recipes/show.html.erb
@@ -1,57 +1,13 @@
 <div class="col-sm-12">
   <div class='row'>
     <div class="col-sm-1">
-      <a href='#' class='js-prevRecipe' data-recipe-id='<%=@recipe.id%>'>&lt;Previous&gt;</a>
+      <a href='/yyy' class='js-prevRecipe'>&lt;Previous&gt;</a>
     </div>
-    <input type='hidden' class='js-currRecipe' value='<%=@recipe.id%>'>
     <div class="col-sm-1">
-      <a href='#' class='js-nextRecipe' data-recipe-id='<%=@recipe.id%>'>&lt;Next&gt;</a>
-    </div>
-  </div>
-  <div class='row recipe-detail'>
-    <div class="col-sm-12">
-      <h1>
-        <%= @recipe.name %> <%= link_to image_tag('edit-icon.png', size:'16', title: 'Edit recipe'), edit_recipe_path(@recipe) if @recipe.author == current_user %>
-        <%= link_to image_tag('delete-icon.png', size:'16', title: 'Delete recipe'), recipe_path(@recipe), method: :delete, data: {confirm: 'Are you sure!'} if policy(@recipe).destroy? %>
-      </h1>
-      <p>Submitted by <%= link_to @recipe.author_name, user_recipes_path(@recipe.author) %></p>
-      <p>
-        <%= image_tag(@recipe.photo_path, size: '360x200', alt: '#{@recipe.name} photo', title: 'recipe photo' ) %>
-        <%= render partial: 'recipes/favorite', locals: {recipe: @recipe} %>
-      </p>
-      <p style='width:40%' align='justify'><%= @recipe.description %></p>
-      <p>Total time: <%= pluralize(number_with_precision(@recipe.total_time, precision: 0), 'minute') %></p>
-      <p>
-        <% if @recipe.recipe_ingredients.length > 0 %>
-          <a href='#' class='js-ingredients' data-recipe-id='<%=@recipe.id%>' data-show-detail='1'>Ingredients</a>
-        <% else %>
-          Ingredients
-        <% end %>
-        (<%= @recipe.recipe_ingredients.length %>)
-      </p>
-      <p id='ingredients'></p>
-      <p>
-        <% if @recipe.recipe_steps.length > 0 %>
-          <a href='#' class='js-steps' data-recipe-id='<%=@recipe.id%>' data-show-detail='1'>Steps</a>
-        <% else %>
-          Steps
-        <% end %>
-        (<%= @recipe.recipe_steps.length %>)
-      </p>
-      <p id='steps'></p>
-      <p>
-        <% if @recipe.recipe_reviews.length > 0 %>
-          <%= link_to 'Reviews', recipe_recipe_reviews_path(@recipe) %>
-        <% else %>
-          Reviews
-        <% end %>
-        (<%= @recipe.recipe_reviews.length %>)
-      </p>
-      <p id='reviews'>
-        <%= render partial: 'recipe_reviews/index', locals: {recipe_reviews: @recipe.recipe_reviews, recipe_id: @recipe.id} %>
-      </p>
+      <a href='/xxx' class='js-nextRecipe'>&lt;Next&gt;</a>
     </div>
   </div>
+  <div class='row recipe-detail'></div>
 </div>
 
 <script id="ingredients-template" type="text/x-handlebars-template">
@@ -66,17 +22,20 @@
 
 <script id="recipe-template" type="text/x-handlebars-template">
   <div class="col-sm-12">
-    <input type='hidden' class='js-currRecipe' value='{{recipe_id}}'>
-    <h1>
-      {{name}}
-      {{{editRecipe recipe_id author_id}}}
-    </h1>
+    <h1>{{name}} {{{editRecipe recipe_id author_id}}}</h1>
     <p>Submitted by <a href='/users/{{user_id}}/recipes'>{{author_name}}</a></p>
     <p>
       <img src='/assets/{{photo_path}}' height='200' width='360' title="{{name}} photo">
+      <input type='checkbox' class='favorite' {{favorite}}>Favorite
     </p>
     <p style='width:40%' align='justify'>{{description}}</p>
     <p>Total time: {{total_time}}</p>
+    <p>Ingredients ({{numIngredients}})</p>
+    <p id='ingredients'></p>
+    <p>Steps ({{numSteps}})</p>
+    <p id='steps'></p>
+    <p>Reviews ({{numReviews}})</p>
+    <p id='reviews'></p>
   </div>
 </script>
 
@@ -120,5 +79,7 @@ $(function () {
         '<a class="js-deleteRecipe" href="#"><img src="/assets/delete-icon.png" height="16" width="16" title="Delete recipe"></a>');
     }
   });
+
+  requestRecipe('current');
 });
 </script>
diff --git a/config/routes.rb b/config/routes.rb
index 34ce88d..f69373e 100644
--- a/config/routes.rb
+++ b/config/routes.rb
@@ -3,14 +3,17 @@ Rails.application.routes.draw do
   devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations', sessions: 'users/sessions' }
 
   resources :ingredients, only: [:index, :show]
+  get '/ingredients/updated_after/:date', to: "ingredients#updated_after"
 
   resources :recipes do
     resources :recipe_ingredients, except: [:show]
     resources :recipe_reviews
     resources :recipe_steps,       except: [:show]
     collection { post 'filter' }
-    get 'navigate', on: :member
   end
+  post '/recipes/save_id/:id',                to: "recipes#save_id"
+  get  '/recipes/updated_after/:date',        to: "recipes#updated_after"
+  get  '/recipe_reviews/updated_after/:date', to: "recipe_reviews#updated_after"
 
   resources :users do
     resources :recipes,               only: [:index]
@@ -20,11 +23,6 @@ Rails.application.routes.draw do
 
   get  '/recent_edits', to: "application#recent_edits_select"
   post '/recent_edits', to: "application#recent_edits"
-
-  get '/ingredients/updated_after/:date',    to: "ingredients#updated_after"
-  get '/recipes/updated_after/:date',        to: "recipes#updated_after"
-  get '/recipe_reviews/updated_after/:date', to: "recipe_reviews#updated_after"
-
-  get '/about', to: "application#about"
+  get  '/about',        to: "application#about"
   root "application#welcome"
 end
