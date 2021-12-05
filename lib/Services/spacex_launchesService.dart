import 'dart:convert';

import 'package:cosmox/API/api.dart';
import 'package:cosmox/models/launchpad_model.dart';
import 'package:cosmox/models/payload_model.dart';
import 'package:cosmox/models/rocket_model.dart';
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

  Future<List<LaunchPadModel>> getAllLaunchPad()async{
    List<LaunchPadModel> listLaunchPadModel = [];
    http.Response response = await http.get(Uri.parse(Api.spaceXLaunchPadApi));
    if(response.statusCode == 200){
      var jsonObject = jsonDecode(response.body);
      for(var i in jsonObject){
        listLaunchPadModel.add(LaunchPadModel().getLaunchPadModel(i));
      }
      return listLaunchPadModel;
    }

   return listLaunchPadModel;
  }

  Future<LaunchPadModel> getLaunchPadById(String launchPadId)async{
      LaunchPadModel launchPadModel = LaunchPadModel();
      http.Response response = await http.get(Uri.parse(Api.spaceXLaunchPadApi+'/$launchPadId'));
      if(response.statusCode == 200){
        var jsonObject = jsonDecode(response.body);
        return launchPadModel.getLaunchPadModel(jsonObject);
      }
    return launchPadModel;
    
  }
  Future<RocketModel> getRocketById(String rocketId)async{
      RocketModel rocketModel = RocketModel();
      http.Response response = await http.get(Uri.parse(Api.spaceXRocketApi+'/$rocketId'));
      if(response.statusCode == 200){
        var jsonObject = jsonDecode(response.body);
        return rocketModel.getRocketModelObject(jsonObject);
      }
    return rocketModel;
    
  }
  Future<PayloadModel> getPayloadById(String payloadId)async{
      PayloadModel payloadModel = PayloadModel();
      http.Response response = await http.get(Uri.parse(Api.spaceXPayloadApi+'/$payloadId'));
      if(response.statusCode == 200){
        var jsonObject = jsonDecode(response.body);
        return payloadModel.getPayloadModelObject(jsonObject);
      }
    return payloadModel;
    
  }

  Future<List<PayloadModel>> getListPayloads(List? payloadsId)async{
    List<PayloadModel> listPayloads = [];
    
    for(var payloadId in payloadsId!){
      listPayloads.add(await getPayloadById(payloadId));
    }

    return listPayloads;
  }

}
