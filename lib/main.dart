import 'package:flutter/material.dart';
import 'package:stepper_bloc_example/src/pages/home/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper Example',
      theme: ThemeData(
        accentColor: Colors.green,
        primaryColor: Colors.black,
      ),
      home: HomePage(),
    );
  }
}
