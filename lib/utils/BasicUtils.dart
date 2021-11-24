import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicUtils{
 static bool isEndOfFeed(ScrollController scrollController){
    if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          return true;
          
        }
      }
   return false;   
  }
static openUrl(String url) async{
   await launch(
      url,
      enableDomStorage: true,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    );
  }

static bool checkScrollingState(ScrollController scrollController){
        if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        return true;
      }
    return false;
}

}