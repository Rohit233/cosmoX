import 'package:cosmox/Services/astronomy_post_services.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          Text(widget.astronomyPostModel!.title.toString()),
         widget.astronomyPostModel!.mediaType == AstronomyPostModel.IMAGE ? (widget.astronomyPostModel!.hdUrl == null ? Image.network(widget.astronomyPostModel!.url.toString()) : Image.network(widget.astronomyPostModel!.hdUrl.toString())) 
         :Container(child: Text('video'),)
        ],
      ),
    );
  }
}