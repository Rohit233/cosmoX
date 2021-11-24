import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:cosmox/models/iss_location_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cosmox/API/api.dart';
import 'package:location/location.dart';

class IssLocationService {
  Future<IssLocationModel?> getLocationIss() async {
    http.Response response = await http.get(Uri.parse(Api.issLocationApi));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      return IssLocationModel().getIssLocationObject(jsonObject);
    }

    return null;
  }

  Future<LocationData?> getUsersLocation(context) async {
    Location location = Location();
    bool serviceEnable;
    PermissionStatus permissionStatus;
    serviceEnable = await location.serviceEnabled();

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      if (permissionStatus != PermissionStatus.granted) {
        if (!serviceEnable) {
          serviceEnable = await location.requestService();
          if(serviceEnable){
            return await location.getLocation();
          }
        }
        else{
          return await location.getLocation();
        }
        
      } else if (permissionStatus != PermissionStatus.deniedForever) {
        permissionDialog(context, 'Allow location permission from setting');
      }
    }
    else if(permissionStatus == PermissionStatus.granted){
      if (!serviceEnable) {
          serviceEnable = await location.requestService();
          if(serviceEnable){
            return await location.getLocation();
          }
        }
        else{
          return await location.getLocation();
        }
    }
    return null;
  }

  permissionDialog(context, String msg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(msg),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    AppSettings.openAppSettings();
                  },
                  child: Text("setting"))
            ],
          );
        });
  }
}
