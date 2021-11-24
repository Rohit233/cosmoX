import 'dart:convert';

import 'package:cosmox/API/api.dart';
import 'package:cosmox/models/article_model.dart';
import 'package:http/http.dart'as http;
class ArticleServices{
  static int limit = 50;
  static int start = 0;
  static late int articlesCount = 0;
  static late int blogsCount = 0;
   Future<List<ArticleModel>> getListArticle() async {
      List<ArticleModel> listArticleModel = [];
      http.Response articleCountResponse = await http.get(Uri.parse(Api.articleApi+'/count'));
      if(articleCountResponse.statusCode == 200){
         articlesCount = int.parse(articleCountResponse.body);
         http.Response blogCountResponse = await http.get(Uri.parse(Api.blogApi+'/count'));
         if(blogCountResponse.statusCode == 200){
            blogsCount = int.parse(blogCountResponse.body);
            http.Response articleResponse = await http.get(Uri.parse(Api.articleApi+'?_start=$start&_limit=$limit'));
            if(articleResponse.statusCode == 200){
              var jsonObject = jsonDecode(articleResponse.body);
              for(var i in jsonObject){
                listArticleModel.add(ArticleModel().getArticleModelObject(i));
              }
              
            }
            http.Response blogResponse = await http.get(Uri.parse(Api.blogApi+'?_start=$start&_limit=$limit')); 
            if(blogResponse.statusCode == 200){
               var jsonObject = jsonDecode(blogResponse.body);
               for(var i in jsonObject){
                listArticleModel.add(ArticleModel().getArticleModelObject(i));
              }
            }
            start+=51;
            limit+=50;
         }
      }
      return sortedArticleList(listArticleModel);
   }
   
   List<ArticleModel> sortedArticleList(List<ArticleModel> listArticleModel){
      for(int i = 0;i<listArticleModel.length;i++){
         for(int j = 0;j<listArticleModel.length/2;j++){
           ArticleModel tempArticle;
           if(listArticleModel[j].updatedAt.millisecondsSinceEpoch < listArticleModel[j+1].updatedAt.millisecondsSinceEpoch){
             tempArticle = listArticleModel[j];
             listArticleModel[j] = listArticleModel[j+1];
             listArticleModel[j+1] = tempArticle;
           }
         }
      }
      return listArticleModel;
   }
}