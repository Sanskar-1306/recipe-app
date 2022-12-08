import 'package:flutter/cupertino.dart';
import 'package:wit/models/recipe_model.dart';
import 'models/Ingredient.dart';
import 'models/step.dart';

class AppData extends ChangeNotifier {
  List<Ingredient> ingredients = [];
  List<StepModel> steps = [];
  int tabNumber = 0;
  String recipeName = "";
  int recipeServings = 0;
  int prepTimeHour = 0;
  int prepTimeMin = 0;
  int cookingTimeHour = 0;
  int cookingTimeMin = 0;
  String uid = "";
  Recipe recipe = new Recipe("", 0, TimeRecipe(0, 0), TimeRecipe(0, 0), [], []);
  void updateIngridients(newIngredients) {
    ingredients = newIngredients;
    notifyListeners();
  }

  void updateSteps(newSteps) {
    steps = newSteps;
    notifyListeners();
  }

  void updateTab(newTabNumber) {
    tabNumber = newTabNumber;
    notifyListeners();
  }

  void updateRecipe(Recipe newRecipe) {
    recipeName = newRecipe.name;
    recipeServings = newRecipe.noOfServers;
    cookingTimeHour = newRecipe.cookTime.hours;
    cookingTimeMin = newRecipe.cookTime.minutes;
    prepTimeMin = newRecipe.prepTime.minutes;
    prepTimeHour = newRecipe.prepTime.hours;
    ingredients = newRecipe.ingridents;
    steps = newRecipe.steps;
    recipe = newRecipe;
    notifyListeners();
  }

  void updateUid(newUid) {
    uid = newUid;
  }
}
