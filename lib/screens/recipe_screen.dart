import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wit/screens/create_recipe.dart';
import 'package:wit/models/recipe_model.dart';

class RecipeScreen extends StatefulWidget {
  Recipe recipe;
  RecipeScreen(this.recipe);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(children: [
          Text(
            this.widget.recipe.name,
            style: TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Text("Prep Time"),
                            Text(
                                "${this.widget.recipe.prepTime.hours} hours ${this.widget.recipe.prepTime.minutes} minutes")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Text("Cooking Time"),
                            Text(
                                "${this.widget.recipe.cookTime.hours} hours ${this.widget.recipe.cookTime.minutes} minutes")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Text("Serves"),
                            Text("${this.widget.recipe.noOfServers} persons")
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            "Ingridients",
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.builder(
                  itemCount: this.widget.recipe.ingridents.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: Material(
                        elevation: 2,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                      "${this.widget.recipe.ingridents[i].name}"),
                                  Text(
                                      "${this.widget.recipe.ingridents[i].quantity}")
                                ],
                              ),
                            )),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Steps ",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
              flex: 7,
              child: CarouselSlider.builder(
                itemCount: this.widget.recipe.steps.length,
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Material(
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Text(
                                  "${this.widget.recipe.steps[itemIndex].stepName}",
                                  style: TextStyle(fontSize: 20),
                                )),
                                Container(
                                    child: Text(
                                        "Step Instruction: ${this.widget.recipe.steps[itemIndex].stepInstruction}")),
                                Container(
                                    child: Text(
                                        "Personal Touch is: ${this.widget.recipe.steps[itemIndex].personalTouch}")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(enableInfiniteScroll: false),
              ))
        ]),
      ),
    );
  }
}
