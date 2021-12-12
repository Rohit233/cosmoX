import 'dart:io';

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

  static bool checkScrollingState(ScrollController scrollController) {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      return true;
    }
    return false;
  }

  static Widget loadingShimmer({double? width, double? height, Widget? child}) {
    return Shimmer.fromColors(
      baseColor: Colors.black38,
      highlightColor: Colors.grey,
      child: child ??
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
            width: width,
            height: height,
          ),
    );
  }

  static Widget loadingCard(context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Color.fromRGBO(0, 0, 0, 0.01),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BasicUtils.loadingShimmer(
                width: MediaQuery.of(context).size.width - 120, height: 200),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BasicUtils.loadingShimmer(width: 150, height: 15),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BasicUtils.loadingShimmer(width: 150, height: 15),
            )
          ],
        ),
      ),
    );
  }

  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
