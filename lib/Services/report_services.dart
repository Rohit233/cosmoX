import 'dart:convert';

import 'package:cosmox/API/api.dart';
import 'package:cosmox/models/report_model.dart';
import 'package:http/http.dart'as http;
class ReportServices{
  static int limit = 50;
  static int start = 0;
  static late int reportCount = 0;

  Future<List<ReportModel>> getReport()async{
    List<ReportModel> listReportModel = [];
    http.Response reportCountResponse = await http.get(Uri.parse(Api.reportApi+'/count'));
    if(reportCountResponse.statusCode == 200){
      reportCount = int.parse(reportCountResponse.body);
      http.Response response = await http.get(Uri.parse(Api.reportApi+'?_start=$start&_limit=$limit'));
    if(response.statusCode == 200){
       var jsonObject = jsonDecode(response.body);
       for(var i in jsonObject){
         listReportModel.add(ReportModel().getReportModelObject(i));
       }
       start+=51;
       limit+=50;
       return listReportModel;
    }
    }
    return listReportModel;
  }
}