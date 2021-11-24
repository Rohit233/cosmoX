class ReportModel{
  late int _id;
  late String _title;
  late String _url;
  late String _imageUrl;
  late String _newsSite;
  late String _summary;
  late String _publishedAt;
  late String _updatedAt;

 int get id => this._id;

 set id(int id) => this._id = id;

 String get title => this._title;

 set title(String title) => this._title = title;

 String get url => this._url;

 set url(String url) => this._url = url;

 String get imageUrl => this._imageUrl;

 set imageUrl(String imageUrl) => this._imageUrl = imageUrl;

 String get newsSite => this._newsSite;

 set newsSite(String newsSite) => this._newsSite = newsSite;

 String get summary => this._summary;

 set summary(String summary) => this._summary = summary;

 String get publishedAt => this._publishedAt;

 set publishedAt(String publishedAt) => this._publishedAt = publishedAt;

 String get updatedAt => this._updatedAt;

 set updatedAt(String updatedAt) => this._updatedAt = updatedAt;

 ReportModel getReportModelObject(data){
   ReportModel reportModel = ReportModel();
   reportModel.id = data['id'];
   reportModel.title = data['title'];
   reportModel.url = data['url'];
   reportModel.imageUrl = data['imageUrl'];
   reportModel.newsSite = data['newsSite'];
   reportModel.summary = data['summary'];
   reportModel.publishedAt =  data['publishedAt'];
   reportModel.updatedAt = data['updatedAt'];
   return reportModel;

 }

}