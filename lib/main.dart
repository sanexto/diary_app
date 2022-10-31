import 'package:flutter/material.dart';

import 'package:diary_app/db/db.dart';

import 'package:diary_app/pages/home_page.dart';

void main() {

  runApp(const App());

}

class App extends StatelessWidget {

  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Diary App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(
        db: DB(),
      ),
    );

  }

}