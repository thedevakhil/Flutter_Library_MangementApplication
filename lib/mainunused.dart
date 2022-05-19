import 'package:flutter/material.dart';
import 'student/nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: '1',
      theme: ThemeData(
        // Define the default brightness and colors.

          accentColor: Colors.purple),
      home: Nav(),
      debugShowCheckedModeBanner: false,
    );
  }
}