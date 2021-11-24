import 'package:cosmox/utils/DateTimeUtils.dart';

class ArticleModel{
  late int _id;
  late String _title;
  late String _url;
  late String _imageUrl;
  late String _newsSite;
  late String _summary;
  late DateTime _publishedAt;
  late DateTime _updatedAt;

 int get id => this._id;

 set id(int id) => this._id = id;

 String get title => this._title;

 set title(String value) => this._title = value;

 String get url => this._url;

 set url(String url) => this._url = url;

 String get imageUrl => this._imageUrl;

 set imageUrl(String imageUrl) => this._imageUrl = imageUrl;

 String get newsSite => this._newsSite;

 set newsSite(String newsSite) => this._newsSite = newsSite;

 String get summary => this._summary;

 set summary(String summary) => this._summary = summary;

 DateTime get publishedAt => this._publishedAt;

 set publishedAt(DateTime publishedAt) => this._publishedAt = publishedAt;

 DateTime get updatedAt => this._updatedAt;

 set updatedAt(DateTime updatedAt) => this._updatedAt = updatedAt;

 ArticleModel getArticleModelObject(data){
    ArticleModel articleModel = ArticleModel();
    articleModel.id = data['id'];
    articleModel.title = data['title'];
    articleModel.url = data['url'];
    articleModel.imageUrl = data['imageUrl'];
    articleModel.newsSite = data['newsSite'];
    articleModel.summary = data['summary'];
    articleModel.publishedAt = DateTimeUtils.getDateTimeForStringOfDateTime(data['publishedAt']);
    articleModel.updatedAt = DateTimeUtils.getDateTimeForStringOfDateTime(data['updatedAt']);
    return articleModel;
 }

}