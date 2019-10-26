import 'package:flutter/material.dart';

import 'welcome.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recipe Foods',
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.teal,
            accentColor: Colors.redAccent),
        home: WelcomePage());
  }
}
