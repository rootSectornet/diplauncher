import 'package:flutter/material.dart';

import 'homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dip Launcher',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Homescreen(),
    );
  }
}