library cosmox.globals;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
ValueNotifier<int> currentTab = ValueNotifier(0);
LocationData userLocationData = LocationData.fromMap({});
CircularProgressIndicator circularProgressIndicator = CircularProgressIndicator(strokeWidth: 0.9,);
TextStyle textStyle = GoogleFonts.abel(fontSize: 17);