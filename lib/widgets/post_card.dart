import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:cosmox/widgets/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostCard extends StatefulWidget {
  final AstronomyPostModel? astronomyPostModel;
  const PostCard({Key? key, this.astronomyPostModel}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isReadMore = false;
  bool isErrorImage = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Card(
            color: Color.fromRGBO(0, 0, 0, 0.01),
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        StatefulBuilder(builder: (context,state){
                          return  widget.astronomyPostModel!.mediaType ==
                            AstronomyPostModel.IMAGE
                            ? Ink.image(
                              onImageError: (context,onImageError){
                                  isErrorImage = true;
                                  state((){});
                              },
                                image: widget.astronomyPostModel!.hdUrl != null
                                    ? isErrorImage ? AssetImage(largeIcon) as ImageProvider : CachedNetworkImageProvider(widget
                                        .astronomyPostModel!.hdUrl
                                        .toString())
                                    : isErrorImage ? AssetImage(largeIcon) as ImageProvider :  CachedNetworkImageProvider(widget
                                        .astronomyPostModel!.url
                                        .toString()),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return PhotoViewWidget(imageUrl: widget.astronomyPostModel!.hdUrl ?? widget.astronomyPostModel!.url?? "");
                                    }));
                                  },
                                ),
                                height: 270,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                child: YoutubePlayer(
                                  controller: YoutubePlayerController(
                                      initialVideoId:
                                          YoutubePlayer.convertUrlToId(widget
                                                  .astronomyPostModel!.url
                                                  .toString())
                                              .toString(),
                                      flags: YoutubePlayerFlags(
                                        autoPlay: false,
                                        hideControls: false,
                                        mute: false,
                                        controlsVisibleAtStart: false,
                                      )),
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor: Colors.redAccent,
                                ),
                              );
                        }),
                       
                        Positioned(
                          bottom: 16,
                          right: 16,
                          left: 16,
                          child: Text(
                            widget.astronomyPostModel!.title.toString(),
                            style:GoogleFonts.abel(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.astronomyPostModel!.date ?? "",
                          style: textStyle,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8).copyWith(bottom: 0),
                        child: buildText(
                          widget.astronomyPostModel!.explanation.toString(),
                        )),
                    SizedBox(height: 8),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(isReadMore ? 'Read Less' : 'Read More',style: textStyle,),
                          onPressed: () =>
                              setState(() => isReadMore = !isReadMore),
                        )
                      ],
                    )
                  ],
                ))),
      ),
    );
  }

  Widget buildText(String text) {
    final maxLines = isReadMore ? null : 5;
    final overflow = isReadMore ? TextOverflow.visible : TextOverflow.ellipsis;
    return Text(text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: TextAlign.justify,
        style: textStyle,);
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