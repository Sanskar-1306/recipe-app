import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/app_data.dart';

import '../models/Ingredient.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({Key? key}) : super(key: key);

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  List<Ingredient> ingridients = [
    Ingredient("ingr1", 10),
    Ingredient("ingri2", 20)
  ];

  final TextEditingController ingredientNameControlller =
      TextEditingController();
  final TextEditingController ingredientQuantityController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    ingridients = Provider.of<AppData>(context, listen: false).ingredients;
    return Container(
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
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(ingridients[i].name),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
            child: FloatingActionButton(
              heroTag: "add ingridient",
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: ingredientNameControlller,
                              )),
                              Expanded(
                                  child: TextField(
                                controller: ingredientQuantityController,
                                keyboardType: TextInputType.number,
                              ))
                            ],
                          ),
                          FloatingActionButton.extended(
                            label: Text("Add Ingredient"),
                            onPressed: () {
                              setState(() {
                                ingridients.add(Ingredient(
                                    ingredientNameControlller.text,
                                    int.parse(
                                        ingredientQuantityController.text)));
                              });
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ));
                    });
              },
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
