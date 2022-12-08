import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/app_data.dart';
import 'package:wit/constants/button.dart';
import 'package:wit/constants/textInputStyle.dart';
import 'package:wit/functions/create_recipe_function.dart';
import 'package:wit/functions/update_recipe_function.dart';
import 'package:wit/screens/loading_screen.dart';
import 'package:wit/models/recipe_model.dart';
import 'package:wit/models/step.dart';
import 'package:wit/screens/recipies.dart';
import 'package:wit/screens/step_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Ingredient.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({Key? key}) : super(key: key);

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController recipeNameControlller = TextEditingController();
  final TextEditingController recipeServingsController =
      TextEditingController();
  final TextEditingController cookingTimeHourControlller =
      TextEditingController();
  final TextEditingController cookingTimeMinuteController =
      TextEditingController();
  final TextEditingController preparationTimeHourControlller =
      TextEditingController();
  final TextEditingController preparationTimeMinuteController =
      TextEditingController();
  final TextEditingController ingredientNameControlller =
      TextEditingController();
  final TextEditingController ingredientQuantityController =
      TextEditingController();
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  List<Ingredient> ingridients = [
    Ingredient("ingr1", 10),
    Ingredient("ingri2", 20)
  ];
  List<StepModel> steps = [];

  void showIngredientModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Colors.grey.shade200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: kTextInputStyle.copyWith(
                                hintText: "Ingridient name"),
                            controller: ingredientNameControlller,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: kTextInputStyle.copyWith(
                                hintText: "Ingredient Quantity"),
                            controller: ingredientQuantityController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonWidget(() {
                      setState(() {
                        ingridients.add(Ingredient(
                            ingredientNameControlller.text,
                            int.parse(ingredientQuantityController.text)));
                      });
                      Navigator.pop(context);
                    }, "Add"),
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    steps = Provider.of<AppData>(context, listen: false).steps;
    ingridients = Provider.of<AppData>(context, listen: false).ingredients;
    recipeNameControlller.text =
        Provider.of<AppData>(context, listen: false).recipeName;
    recipeServingsController.text =
        Provider.of<AppData>(context, listen: false).recipeServings.toString();
    cookingTimeHourControlller.text =
        Provider.of<AppData>(context, listen: false).cookingTimeHour.toString();
    cookingTimeMinuteController.text =
        Provider.of<AppData>(context, listen: false).cookingTimeMin.toString();
    preparationTimeHourControlller.text =
        Provider.of<AppData>(context, listen: false).prepTimeHour.toString();
    preparationTimeMinuteController.text =
        Provider.of<AppData>(context, listen: false).prepTimeMin.toString();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Recipe"),
          bottom: TabBar(
              onTap: (i) {
                Recipe recipe = Recipe(
                    recipeNameControlller.text,
                    int.parse(recipeServingsController.text),
                    TimeRecipe(int.parse(preparationTimeHourControlller.text),
                        int.parse(preparationTimeMinuteController.text)),
                    TimeRecipe(int.parse(cookingTimeHourControlller.text),
                        int.parse(cookingTimeMinuteController.text)),
                    steps,
                    ingridients);
                updateRecipeProvider(recipe, context);
              },
              tabs: [
                const Tab(text: "Recipe"),
                const Tab(text: "Ingredients"),
                const Tab(text: "Steps")
              ]),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Card(
                          elevation: 10,
                          child: Image.network(
                            'https://www.pngfind.com/pngs/m/66-661092_png-file-upload-image-icon-png-transparent-png.png',
                            width: 100,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: recipeNameControlller,
                                  validator: (v) {
                                    if (v!.length == 0)
                                      return "please enter some text";
                                    return null;
                                  },
                                  decoration: kTextInputStyle.copyWith(
                                      hintText: "Recipe name (Ex: Pasta)")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: recipeServingsController,
                                  decoration: kTextInputStyle.copyWith(
                                      hintText: "No of servings")),
                            ),
                            Text("Preperation Time"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                        controller:
                                            preparationTimeHourControlller,
                                        decoration: kTextInputStyle.copyWith(
                                            hintText: "HH")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(":"),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                        controller:
                                            preparationTimeMinuteController,
                                        validator: (v) {
                                          if (int.parse(v!) > 60)
                                            return "minutes should be less than 60";
                                          return null;
                                        },
                                        decoration: kTextInputStyle.copyWith(
                                            hintText: "MM")),
                                  ),
                                ],
                              ),
                            ),
                            Text("Cooking Time"),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: cookingTimeHourControlller,
                                        decoration: kTextInputStyle.copyWith(
                                            hintText: "HH")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(":"),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        controller: cookingTimeMinuteController,
                                        validator: (v) {
                                          if (int.parse(v!) > 60)
                                            return "minutes should be less than 60";
                                          return null;
                                        },
                                        decoration: kTextInputStyle.copyWith(
                                            hintText: "MM")),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: ingridients.length,
                      itemBuilder: (BuildContext context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(ingridients[i].name),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text("${ingridients[i].quantity}"),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            ingridients.removeAt(i);
                                          });
                                        },
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                              )),
                        );
                      }),
                )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonWidget(() {
                      showIngredientModal();
                    }, "Add Ingridient"))
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: steps.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StepScreen(steps[i], i)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: ListTile(
                                        title: Row(
                                      children: [
                                        Text(steps[i].stepName),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                steps.remove(steps[i]);
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                            ))
                                      ],
                                    )),
                                  ),
                                ));
                          })),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonWidget(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StepScreen(StepModel("", "", ""), -1)));
                    }, "Add New Step"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonWidget(() {
                      Recipe recipe =
                          Provider.of<AppData>(context, listen: false).recipe;
                      if (_formKey.currentState!.validate()) {
                        uploadRecipe(recipe, context).then((value) => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipeListScreen()))
                            });
                      }
                    }, "Create Recipe"),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
