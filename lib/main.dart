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
        brightness: Brightness.dark,
        tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.grey[300]),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(
              color: Colors.white,
            ),
            selectedIconTheme: IconThemeData(color: Colors.blueAccent),
            unselectedItemColor: Colors.white),
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
