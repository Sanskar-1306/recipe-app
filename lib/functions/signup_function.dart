import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/app_data.dart';
import 'package:wit/screens/loading_screen.dart';
import 'package:wit/screens/recipies.dart';

void registerUser(BuildContext context, TextEditingController emailController,
    TextEditingController passwordController) {
  print("registration started");
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoadingScreen()));
  firebaseAuth
      .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
      .then((result) {
    Provider.of<AppData>(context, listen: false).updateUid(result.user.email);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecipeListScreen()));
  }).catchError((err) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(err.message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  });
}
