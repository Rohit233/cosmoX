import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicUtils {
  static bool isEndOfFeed(ScrollController scrollController) {
    if (scrollController.position.atEdge) {
      if (scrollController.position.pixels != 0) {
        return true;
      }
    }
    return false;
  }

  static openUrl(String url) async {
    await launch(
      url,
      enableDomStorage: true,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    );
  }

  static Future openBottomSheet(
      context, child, AnimationController? animationController,
      {isScrollControlled = true,
      minChildSize = 0.75,
      initialChildSize = 0.96,
      maxChildSize = 1.0,
      enableDrag = true}) async {
    if (animationController != null) {
      animationController.duration = Duration(milliseconds: 600);
    }
    return await showModalBottomSheet(
        transitionAnimationController: animationController ?? null,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        isScrollControlled: isScrollControlled,
        enableDrag: enableDrag,
        backgroundColor: Colors.transparent,
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: initialChildSize,
            maxChildSize: maxChildSize,
            minChildSize: minChildSize,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                    padding: EdgeInsets.only(bottom: 30.0),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: child(scrollController)),
              );
            }));
  }

  static bool checkScrollingState(ScrollController scrollController) {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      return true;
    }
    return false;
  }

  static Widget loadingShimmer({required double width,required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.black38,
      highlightColor: Colors.grey,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        width: width,
        height: height,
      ),
    );
  }
}
