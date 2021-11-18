import 'dart:convert';
import 'package:cosmox/API/api.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:http/http.dart' as http;

class AstronomyPostServices {
  static late int lastFetchPostDate = -1;

  Future<List<AstronomyPostModel>?> getPostWhileScrolling() async {
    List<AstronomyPostModel> astronomyPost = [];
    String startDate = DateTimeUtils.getFormatedDateFromEpoch(
        DateTimeUtils.getCurrentEpoch() - (86400000 * 5));
    String endDate;
    if (lastFetchPostDate == -1) {
      endDate = DateTimeUtils.getFormatedDateFromEpoch(
          DateTimeUtils.getCurrentEpoch());
      http.Response response = await http.get(Uri.parse(
          Api.astronomyPictureOfDayApi +
              '&start_date=$startDate&end_date=$endDate&thumbs=True'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        for (var i in jsonResponse) {
          astronomyPost.add(AstronomyPostModel().getAstronomyPostObject(i));
        }
        return astronomyPost;
      }
    }
    return null;
  }
}
