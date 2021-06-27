import 'package:flutter/material.dart';
import 'package:wordse_app/src/pages/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wordse",
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
