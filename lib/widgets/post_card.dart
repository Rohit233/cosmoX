import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmox/Services/astronomy_post_services.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostCard extends StatefulWidget {
  final AstronomyPostModel? astronomyPostModel;
  const PostCard({Key? key, this.astronomyPostModel}) : super(key: key);

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
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget.astronomyPostModel!.title.toString())),
                ),
                Text(widget.astronomyPostModel!.date.toString())
              ],
            ),
          ),
          widget.astronomyPostModel!.mediaType == AstronomyPostModel.IMAGE
              ? (widget.astronomyPostModel!.hdUrl == null
                  ? AspectRatio(
                    aspectRatio: 1,
                    child: PhotoView(
                        disableGestures: true,
                        backgroundDecoration: BoxDecoration(color: Colors.white),
                        loadingBuilder: (context, imageChunkEvent) {
                          return Center(child: CircularProgressIndicator());
                        },
                        imageProvider: CachedNetworkImageProvider(widget.astronomyPostModel!.url.toString(),)),
                  )
                  : AspectRatio(
                    aspectRatio: 1,
                    child: PhotoView(
                        disableGestures: true,
                        backgroundDecoration: BoxDecoration(color: Colors.white),
                        loadingBuilder: (context, imageChunkEvent) {
                          return Center(child: CircularProgressIndicator());
                        },
                        imageProvider: CachedNetworkImageProvider(widget.astronomyPostModel!.hdUrl.toString(),)),
                  ))
              : Container(
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(widget.astronomyPostModel!.url.toString()).toString(),
                      flags: YoutubePlayerFlags(
                        autoPlay: false,
                        hideControls: false,
                        mute: false,
                        controlsVisibleAtStart: false,
                      )
                    ),showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.redAccent,
                  ),
                ),
          Text(
            widget.astronomyPostModel!.explanation.toString(),
          )
        ],
      ),
    );
  }
}
