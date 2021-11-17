import 'package:cosmox/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CosmoX',
      theme: ThemeData(
        bottomNavigationBarTheme:BottomNavigationBarThemeData(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
              color: Colors.black,
          ),
          selectedIconTheme: IconThemeData(
            color: Colors.blueAccent
          ),  
          unselectedItemColor: Colors.black38
        ),
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

