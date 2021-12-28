library cosmox.globals;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:sqflite/sqflite.dart';
ValueNotifier<int> currentTab = ValueNotifier(0);
LocationData userLocationData = LocationData.fromMap({});
CircularProgressIndicator circularProgressIndicator = CircularProgressIndicator(strokeWidth: 0.9,);
TextStyle textStyle = GoogleFonts.abel(fontSize: 17);
int textLengthForCard = 300;
String smallIcon = 'assets/icons/cosmoX 512.png';
String largeIcon = 'assets/icons/cosmoX 1024.png';
late Database db;
  Future openDb()async{
     db = await openDatabase(await getDatabasesPath()+'COSMOX',version: 1,
     );
  }