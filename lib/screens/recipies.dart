import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/app_data.dart';
import 'package:wit/constants/button.dart';
import 'package:wit/functions/logout_function.dart';
import 'package:wit/screens/create_recipe.dart';
import 'package:wit/models/Ingredient.dart';
import 'package:wit/models/recipe_model.dart';
import 'package:wit/models/step.dart';
import 'package:wit/screens/recipe_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                signOut(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(content: Text("Tap again to leave")),
        child: Column(
          children: [
            Text(
              "Welcome!",
              style: TextStyle(fontSize: 17),
            ),
            Text(
              "${Provider.of<AppData>(context, listen: false).uid}",
              style: TextStyle(fontSize: 17),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection(
                            Provider.of<AppData>(context, listen: false).uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Text("Loading")
                          : ListView.builder(
                              itemCount: snapshot.data!.documents.length,
                              itemBuilder: (context, i) {
                                QueryDocumentSnapshot document =
                                    snapshot.data!.documents[i];
                                //print(snapshot.data!.documents[i].runtimeType);
                                List<StepModel> steps = List<StepModel>.from(
                                    document['steps']
                                        .map((e) => StepModel(
                                            e['stepName'],
                                            e['stepInstruction'],
                                            e['personalTouch']))
                                        .toList());
                                List<Ingredient> ingredients =
                                    List<Ingredient>.from(
                                        document['ingredients']
                                            .map((e) => Ingredient(
                                                e['name'], e['quantity']))
                                            .toList());

                                Recipe recipe = Recipe(
                                    document['name'],
                                    document['noOfServers'],
                                    TimeRecipe(document['preptime']['hours'],
                                        document['preptime']['minutes']),
                                    TimeRecipe(document['cookTime']['hours'],
                                        document['cookTime']['minutes']),
                                    steps,
                                    ingredients);
                                print(recipe);
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecipeScreen(recipe)));
                                    },
                                    child: ListTile(
                                        title: Text(snapshot.data!.documents[i]
                                            ['name'])));
                              });
                    }),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateRecipe()));
                }, "Create Recipe"))
          ],
        ),
      ),
    );
  }
}
