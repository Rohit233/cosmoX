import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmox/models/article_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleCard extends StatefulWidget {
  final ArticleModel articleModel;
  const ArticleCard({Key? key, required this.articleModel}) : super(key: key);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  Color myHexColor = Color(0x00000000);
  bool isVisible = true;
  bool isReadMore = false;
  bool isErrorImage = false;
Widget buildText(String text) {
    final overflow = isReadMore ? TextOverflow.visible : TextOverflow.ellipsis;
    return text.length < textLengthForCard ?
     Text( text,
        textAlign: TextAlign.justify,
        style: textStyle,) : Text( !isReadMore ? text.substring(0,textLengthForCard) : text,
        overflow: overflow,
        textAlign: TextAlign.justify,
        style: textStyle,);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () async {
        BasicUtils.openUrl(widget.articleModel.url);
      },
      child: Card(
          color: myHexColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 2, color: Colors.white30)),
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Stack(
                    children: [
                      StatefulBuilder(builder: (context,state){
                        return Ink.image(
                        onImageError: (context, onImageError) {
                          isErrorImage = true;
                          state(() {});
                        },
                        image: isErrorImage ? AssetImage(largeIcon) as ImageProvider : CachedNetworkImageProvider(
                            widget.articleModel.imageUrl.toString()),
                        child: InkWell(
                          onTap: () {
                            BasicUtils.openUrl(widget.articleModel.url);
                          },
                        ),
                        height: 270,
                        fit: BoxFit.cover,
                      );
                      }),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        left: 16,
                        child: Text(
                          widget.articleModel.title.toString(),
                          style: GoogleFonts.abel(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          )
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.articleModel.newsSite,
                      style: GoogleFonts.abel(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Published at',
                                    style: GoogleFonts.abel(
                                      fontSize: 17,
                                      color: Colors.grey
                                    ),
                                  )),
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                Text(DateTimeUtils.getFormatedDateFromEpoch(
                                    widget.articleModel.publishedAt
                                        .millisecondsSinceEpoch),
                                    style: textStyle,    
                                        ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            ),
                            Row(
                              children: [
                                Icon(Icons.watch_outlined),
                                Text(DateTimeUtils.getFormatedTimeFromEpoch(
                                    widget.articleModel.publishedAt
                                        .millisecondsSinceEpoch),
                                    style: textStyle,    
                                        ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Updated at',
                                    style: GoogleFonts.abel(
                                      fontSize: 17,
                                      color: Colors.grey
                                    ),
                                  )),
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                Text(DateTimeUtils.getFormatedDateFromEpoch(
                                    widget.articleModel.updatedAt
                                        .millisecondsSinceEpoch),
                                    style: textStyle,    
                                        ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            ),
                            Row(
                              children: [
                                Icon(Icons.watch_outlined),
                                Text(DateTimeUtils.getFormatedTimeFromEpoch(
                                    widget.articleModel.updatedAt
                                        .millisecondsSinceEpoch),
                                    style: textStyle,    
                                        ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8).copyWith(bottom: 0),
                      child: buildText(widget.articleModel.summary)),
                  SizedBox(height: 8),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                     widget.articleModel.summary.length >=textLengthForCard ?  TextButton(
                          child: Text(isReadMore ? 'Read Less' : 'Read More'),
                          onPressed: () {
                            setState(() => isReadMore = !isReadMore);
                          }) : Container()
                    ],
                  )
                ],
              ))),
    ));
  }
}
