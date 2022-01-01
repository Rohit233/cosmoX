import 'dart:convert';
import 'package:cosmox/API/api.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:http/http.dart' as http;

class AstronomyPostServices {
  static late int lastFetchPostDate = -1;

  static const String TABLENAME = 'astronomyPost';
  static const String ID = 'id';
  static const String DATE = 'date';
  static const String EXPLANATION = 'explanation';
  static const String HD_URL = 'hdUrl';
  static const String MEDIA_TYPE = 'media_type';
  static const String TITLE = 'title';
  static const String URL = 'url';


  Future<List<AstronomyPostModel>?> getPostWhileScrolling() async {
    List<AstronomyPostModel> astronomyPost = [];
    int startDate = DateTimeUtils.getCurrentEpoch() - (86400000 * 5);
    String formatedStartDate =
        DateTimeUtils.getFormatedDateFromEpoch(startDate);
    int endDate;
    if (lastFetchPostDate == -1) {
      endDate = DateTimeUtils.getCurrentEpoch();
      String formatedEndDate = DateTimeUtils.getFormatedDateFromEpoch(endDate);
      try{
        await db.execute('''
         create table $TABLENAME(
           id integer primary key autoincrement,
           $DATE text,
           $EXPLANATION text,
           $HD_URL text,
           $MEDIA_TYPE text,
           $TITLE text,
           $URL text
         )
        ''');
      } catch(e){

      }
      astronomyPost = await getAstronomyPostFromLocalDb();
      if(astronomyPost.isNotEmpty && astronomyPost[0].date == DateTimeUtils.getFormatedDateFromEpoch(DateTimeUtils.getCurrentEpoch())){
        lastFetchPostDate = startDate;
        return astronomyPost;
      }
      http.Response response = await http.get(Uri.parse(Api
              .astronomyPictureOfDayApi +
          '&start_date=$formatedStartDate&end_date=$formatedEndDate&thumbs=True'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        for (var i in jsonResponse) {
          astronomyPost.add(AstronomyPostModel().getAstronomyPostObject(i));
        }
        lastFetchPostDate = startDate;
         await deleteAllAstronomyPostFromLocalDb();
         if(astronomyPost[astronomyPost.length-1].date == DateTimeUtils.getFormatedDateFromEpoch(DateTimeUtils.getCurrentEpoch())){
            await insetAstronomyPostInLocalDb(List.from(astronomyPost.reversed));
         }
       
        return List.from(astronomyPost.reversed);
      }
      else if(response.statusCode == 400){
        return await requestAfterDateError(formatedStartDate,DateTimeUtils.getFormatedDateFromEpoch(endDate-86400000),startDate);
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
      else if(response.statusCode == 400){
        return await requestAfterDateError(formatedStartDate,DateTimeUtils.getFormatedDateFromEpoch(endDate-86400000),startDate);
      }
    }
    return [];
  }


  Future insetAstronomyPostInLocalDb(List<AstronomyPostModel> listAstronomyPostModel)async{
     for(AstronomyPostModel astronomyPostModel in listAstronomyPostModel ){
       await db.insert(TABLENAME, {
       DATE: astronomyPostModel.date,
       EXPLANATION: astronomyPostModel.explanation,
       HD_URL: astronomyPostModel.hdUrl,
       MEDIA_TYPE: astronomyPostModel.mediaType,
       TITLE: astronomyPostModel.title,
       URL: astronomyPostModel.url
      });
     }
  }
  Future deleteAllAstronomyPostFromLocalDb()async{
    try{
      await db.delete(TABLENAME);
    }
    catch(e){

    }
  }

  Future<List<AstronomyPostModel>> requestAfterDateError(String formatedStartDate,String formatedEndDate,int startDate)async{
    List<AstronomyPostModel> astronomyPost = [];
    http.Response response = await http.get(Uri.parse(Api
              .astronomyPictureOfDayApi +
          '&start_date=$formatedStartDate&end_date=$formatedEndDate&thumbs=True'));
     var jsonResponse = jsonDecode(response.body);
        for (var i in jsonResponse) {
          astronomyPost.add(AstronomyPostModel().getAstronomyPostObject(i));
        }
        lastFetchPostDate = startDate;
        return List.from(astronomyPost.reversed);
  }

  Future<List<AstronomyPostModel>> getAstronomyPostFromLocalDb()async{
     List<AstronomyPostModel> listAstronomyPostModel = [];
     List<Map> response = await db.query(TABLENAME,
       columns: [ID,DATE,EXPLANATION,HD_URL,MEDIA_TYPE,TITLE,URL]
     );
     for(var astronomyPostData in response){
       listAstronomyPostModel.add(AstronomyPostModel().getAstronomyPostObject(astronomyPostData));
     }

     return listAstronomyPostModel;
  }

}
