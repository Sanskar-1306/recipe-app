import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  String name;
  int quantity;
  Ingredient(this.name, this.quantity);

  Map toJson() {
    return {"name": name, "quantity": quantity};
  }

  factory Ingredient.fromJson(QueryDocumentSnapshot snapshot) {
    return Ingredient(snapshot['name'], snapshot['quantity']);
  }
}
