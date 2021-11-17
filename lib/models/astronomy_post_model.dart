class AstronomyPostModel{
  late String? _date;
  late String? _explanation;
  late String? _hdUrl;
  late String? _mediaType;
  late String? _title;
  late String? _url;
  static const IMAGE = 'image';
  static const VIDEO = 'video';

  String? get date => _date;
  set date(String? date){
    _date = date;
  }
  String? get explanation => _explanation;
  set explanation(String? explanation){
    _explanation = explanation;
  }
  String? get hdUrl => _hdUrl;
  set hdUrl(String? hdUrl){
    _hdUrl = hdUrl;
  }
  String? get mediaType => _mediaType;
  set mediaType(String? mediaType){
    _mediaType = mediaType;
  }
  String? get title => _title;
  set title(String? title){
    _title = title;
  }
  String? get url => _url;
  set url(String? url){
    _url = url;
  }


 AstronomyPostModel getAstronomyPostObject(data){
    AstronomyPostModel astronomyPostModel = AstronomyPostModel();
    astronomyPostModel._date = data['date'];
    astronomyPostModel.explanation = data['explanation'];
    astronomyPostModel.hdUrl = data['hdUrl'];
    astronomyPostModel.mediaType = data['media_type'];
    astronomyPostModel.title = data['title'];
    astronomyPostModel.url = data['url'];
    return astronomyPostModel;
  }

}