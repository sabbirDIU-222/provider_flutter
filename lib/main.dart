import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/provider/todo_provider.dart';

import 'home.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TodoProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(primaryColor: Colors.deepPurple),
    );
  }
}
