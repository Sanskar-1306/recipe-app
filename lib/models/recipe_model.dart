import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wit/models/Ingredient.dart';
import 'package:wit/models/step.dart';

class Recipe {
  String name;
  //String author;
  int noOfServers;
  TimeRecipe prepTime;
  TimeRecipe cookTime;
  List<StepModel> steps;
  List<Ingredient> ingridents;

  Recipe(this.name, this.noOfServers, this.prepTime, this.cookTime, this.steps,
      this.ingridents);
  dynamic toJson() {
    return {
      "name": name,
      "noOfServers": noOfServers,
      "preptime": this.prepTime.toJson(),
      "cookTime": this.cookTime.toJson(),
      "steps": this.steps.map((e) => e.toJson()).toList(),
      "ingredients": this.ingridents.map((e) => e.toJson()).toList()
    };
  }

  factory Recipe.fromJson(QueryDocumentSnapshot snapshot) {
    return Recipe(
      snapshot['name'],
      snapshot['noOfServers'],
      TimeRecipe.fromJson(snapshot['preptime']),
      TimeRecipe.fromJson(snapshot['cookTime']),
      snapshot['steps'].map((e) => StepModel.fromJson(e)).toList(),
      snapshot['ingredients'].map((e) => StepModel.fromJson(e)).toList(),
    );
  }
}

class TimeRecipe {
  int hours;
  int minutes;
  TimeRecipe(this.hours, this.minutes);

  Map toJson() {
    return {"hours": hours, "minutes": minutes};
  }

  factory TimeRecipe.fromJson(QueryDocumentSnapshot snapshot) {
    return TimeRecipe(snapshot['hours'], snapshot['minutes']);
  }
}
