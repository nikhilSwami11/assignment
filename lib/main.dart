import 'package:flutter/material.dart';
import 'package:yobo_project/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yobo assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Taking the Arguments here.
      home: const HomeScreen(numberOfCircles: 6, completedCircles: 4),
    );
  }
}
