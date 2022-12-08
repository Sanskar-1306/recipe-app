import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wit/app_data.dart';
import 'package:wit/models/recipe_model.dart';

void updateRecipeProvider(Recipe recipe, BuildContext context) {
  Provider.of<AppData>(context, listen: false).updateRecipe(recipe);
}
