import 'package:cosmox/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main()async {
  await dotenv.load(fileName: '.env');
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
            selectedLabelStyle: GoogleFonts.abel(
              color: Colors.white,
              fontSize: 15
            ),
            selectedIconTheme: IconThemeData(color: Colors.blueAccent),
            unselectedItemColor: Colors.white),
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
