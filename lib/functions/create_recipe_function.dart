import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/app_data.dart';
import 'package:wit/screens/loading_screen.dart';
import 'package:wit/models/recipe_model.dart';

Future<void> uploadRecipe(Recipe recipe, BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoadingScreen()));
  String uid = Provider.of<AppData>(context, listen: false).uid;
  print("uploading");
  try {
    await Firestore.instance.collection(uid).add(recipe.toJson());
    Provider.of<AppData>(context).updateRecipe(
        Recipe("", 0, TimeRecipe(0, 0), TimeRecipe(0, 0), [], []));
  } catch (e) {
    print(e);
  }
  Navigator.pop(context);
  print("uploaded");
}
