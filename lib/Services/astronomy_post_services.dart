import 'dart:convert';
import 'package:cosmox/API/api.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:http/http.dart' as http;

class AstronomyPostServices {
  static late int lastFetchPostDate = -1;

  Future<List<AstronomyPostModel>?> getPostWhileScrolling() async {
    List<AstronomyPostModel> astronomyPost = [];
    int startDate = DateTimeUtils.getCurrentEpoch() - (86400000 * 5);
    String formatedStartDate =
        DateTimeUtils.getFormatedDateFromEpoch(startDate);
    int endDate;
    if (lastFetchPostDate == -1) {
      endDate = DateTimeUtils.getCurrentEpoch();
      String formatedEndDate = DateTimeUtils.getFormatedDateFromEpoch(endDate);
      http.Response response = await http.get(Uri.parse(Api
              .astronomyPictureOfDayApi +
          '&start_date=$formatedStartDate&end_date=$formatedEndDate&thumbs=True'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        for (var i in jsonResponse) {
          astronomyPost.add(AstronomyPostModel().getAstronomyPostObject(i));
        }
        lastFetchPostDate = startDate;
        return List.from(astronomyPost.reversed);
      }
    } else {
      int startDate = lastFetchPostDate - (86400000 * 5);
      String formatedStartDate =
          DateTimeUtils.getFormatedDateFromEpoch(startDate);
      int endDate;
      endDate = lastFetchPostDate - (86400000);
      String formatedEndDate = DateTimeUtils.getFormatedDateFromEpoch(endDate);
      http.Response response = await http.get(Uri.parse(Api
              .astronomyPictureOfDayApi +
          '&start_date=$formatedStartDate&end_date=$formatedEndDate&thumbs=True'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        for (var i in jsonResponse) {
          astronomyPost.add(AstronomyPostModel().getAstronomyPostObject(i));
        }
        lastFetchPostDate = startDate;
        return List.from(astronomyPost.reversed);
      }
    }
    return [];
  }
}
