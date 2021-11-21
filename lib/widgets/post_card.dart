import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final AstronomyPostModel? astronomyPostModel;
  const PostCard({Key? key, this.astronomyPostModel}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isReadMore = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            color: Color.fromRGBO(0, 0, 0, 0.8),
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                              widget.astronomyPostModel!.url.toString()),
                          child: InkWell(
                            onTap: () {},
                          ),
                          height: 270,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          left: 16,
                          child: Text(
                            widget.astronomyPostModel!.title.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Padding(
                        padding: EdgeInsets.all(16).copyWith(bottom: 0),
                        child: buildText(
                          widget.astronomyPostModel!.explanation.toString(),
                        )),
                    SizedBox(height: 8),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(isReadMore ? 'Read Less' : 'Read More'),
                          onPressed: () =>
                              setState(() => isReadMore = !isReadMore),
                        )
                      ],
                    )
                  ],
                ))));
  }

  Widget buildText(String text) {
    final maxLines = isReadMore ? null : 5;
    final overflow = isReadMore ? TextOverflow.visible : TextOverflow.ellipsis;
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(fontSize: 18, color: Colors.white));
  }
}
 

// color: Colors.black12,
//       padding: EdgeInsets.all(12),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(widget.astronomyPostModel!.title.toString())),
//           ),
//           widget.astronomyPostModel!.mediaType == AstronomyPostModel.IMAGE
//               ? (widget.astronomyPostModel!.hdUrl == null
//                   ? CachedNetworkImage(
//                       imageUrl: widget.astronomyPostModel!.url.toString(),
//                     )
//                   : CachedNetworkImage(
//                       imageUrl: widget.astronomyPostModel!.hdUrl.toString()))
//               : Container(
//                   child: Text('video'),
//                 ),
//           Text(
//             widget.astronomyPostModel!.explanation.toString(),
//           )
//         ],
//       ),








// 2nd Dummy Code

// Card(
//         color: Color.fromRGBO(0, 0, 0, 0.7),
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//         elevation: 50.0,
//         margin: EdgeInsets.all(15.0),
//         shadowColor: Colors.black,
//         clipBehavior: Clip.antiAlias,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Align(
//                   alignment: Alignment.center,
//                   // Title of Card
//                   child: Text(widget.astronomyPostModel!.title.toString())),
//             ),
//             widget.astronomyPostModel!.mediaType == AstronomyPostModel.IMAGE
//                 ? (widget.astronomyPostModel!.hdUrl == null
//                     ? AspectRatio(
//                         aspectRatio: 1,
//                         child: PhotoView(
//                             disableGestures: true,
//                             backgroundDecoration:
//                                 BoxDecoration(color: Colors.white),
//                             loadingBuilder: (context, imageChunkEvent) {
//                               return Center(child: CircularProgressIndicator());
//                             },
//                             // Image Provider HD/SD
//                             imageProvider: CachedNetworkImageProvider(
//                               widget.astronomyPostModel!.url.toString(),
//                             )),
//                       )
//                     : AspectRatio(
//                         aspectRatio: 0,
//                         child: PhotoView(
//                             disableGestures: true,
//                             backgroundDecoration:
//                                 BoxDecoration(color: Colors.white),
//                             loadingBuilder: (context, imageChunkEvent) {
//                               return Center(child: CircularProgressIndicator());
//                             },
//                             // Image Provider HD/SD
//                             imageProvider: CachedNetworkImageProvider(
//                               widget.astronomyPostModel!.hdUrl.toString(),
//                             )),
//                       ))
//                 : Container(
//                     child: YoutubePlayer(
//                       controller: YoutubePlayerController(
//                           initialVideoId: YoutubePlayer.convertUrlToId(
//                                   widget.astronomyPostModel!.url.toString())
//                               .toString(),
//                           flags: YoutubePlayerFlags(
//                             autoPlay: false,
//                             hideControls: false,
//                             mute: false,
//                             controlsVisibleAtStart: false,
//                           )),
//                       showVideoProgressIndicator: true,
//                       progressIndicatorColor: Colors.redAccent,
//                     ),
//                   ),
//             Text(
//               // Text for Explatinion
//               widget.astronomyPostModel!.explanation.toString(),
//               textAlign: TextAlign.justify,
//               style: TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),