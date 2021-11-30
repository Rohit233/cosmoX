import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewWidget extends StatefulWidget {
  final String imageUrl;
  PhotoViewWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _PhotoViewWidgetState createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {
  PhotoViewController photoViewController = PhotoViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(
          controller: photoViewController,
          onScaleEnd: (context, scaleEndDetails, photoViewControllerValue) {
            photoViewController.reset();
          },
          minScale: 0.3,
          maxScale: 3.0,
          imageProvider: CachedNetworkImageProvider(widget.imageUrl),
        ),
      ),
    );
  }
}
