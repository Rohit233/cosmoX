import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmox/Services/astronomy_post_services.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class PostCard extends StatefulWidget {
  final AstronomyPostModel? astronomyPostModel;
  const PostCard({ Key? key,this.astronomyPostModel}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.astronomyPostModel!.title.toString())),
          ),
         widget.astronomyPostModel!.mediaType == AstronomyPostModel.IMAGE ? (widget.astronomyPostModel!.hdUrl == null ?  CachedNetworkImage(imageUrl: widget.astronomyPostModel!.url.toString(),)
          : CachedNetworkImage(imageUrl: widget.astronomyPostModel!.hdUrl.toString())) 
         :Container(child: Text('video'),),
         Text(widget.astronomyPostModel!.explanation.toString(),
         
         )
        ],
      ),
    );
  }
}