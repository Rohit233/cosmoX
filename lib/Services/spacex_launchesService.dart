import 'dart:convert';

import 'package:cosmox/API/api.dart';
import 'package:cosmox/models/spacex_launches_model.dart';

import 'package:http/http.dart' as http;

class SpaceXLaunchesService {
  Future<List<SpaceXLaunchesModel>?> upcommingLaunches() async {
    List<SpaceXLaunchesModel> upcommingLaunches = [];
    http.Response response =
        await http.get(Uri.parse(Api.spacexLaunchesApi + "/upcoming"));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      for (var i in jsonObject) {
        upcommingLaunches.add(SpaceXLaunchesModel.getSpaceXLaunchObject(i));
      }
      return upcommingLaunches;
    }
    return null;
  }

  Future<List<SpaceXLaunchesModel>?> pastLaunches() async {
    List<SpaceXLaunchesModel> pastLaunches = [];
    http.Response response =
        await http.get(Uri.parse(Api.spacexLaunchesApi + "/past"));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      for(var i in jsonObject){
       pastLaunches.add(SpaceXLaunchesModel.getSpaceXLaunchObject(i));
      }
      return pastLaunches;
    }
    return null;
  }
}
