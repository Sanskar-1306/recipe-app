import 'package:firebase_auth/firebase_auth.dart';
import 'package:wit/screens/loading_screen.dart';
import 'package:wit/screens/login_screen.dart';
import 'package:flutter/material.dart';

void signOut(BuildContext context) async {
  try {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoadingScreen()));
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e);
  }
  Navigator.pop(context);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LoginScreen()));
}
