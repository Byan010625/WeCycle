import 'package:flutter/material.dart';
import 'Login/intro.dart';
import 'Login/signup.dart';
import 'Login/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Intro(),
    );
  }
}
