library cosmox.globals;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
ValueNotifier<int> currentTab = ValueNotifier(0);
LocationData userLocationData = LocationData.fromMap({});
