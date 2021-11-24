import 'package:flutter/material.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

class UrlPreview extends StatefulWidget {
  final String url;
  final double? previewHeight;
  const UrlPreview({Key? key,required this.url,this.previewHeight}) : super(key: key);

  @override
  _UrlPreviewState createState() => _UrlPreviewState();
}

class _UrlPreviewState extends State<UrlPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SimpleUrlPreview(
          url: widget.url,
          previewHeight: widget.previewHeight ?? 130,
      ),
    );
  }
}