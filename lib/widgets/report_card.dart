import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmox/models/report_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportCard extends StatefulWidget {
  final ReportModel reportModel;
  const ReportCard({Key? key, required this.reportModel}) : super(key: key);

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  bool isReadMore = false;
    bool isErrorImage = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
          onTap: ()async{
              BasicUtils.openUrl(widget.reportModel.url);
          },
          child: Card(
              color: Color.fromRGBO(0, 0, 0, 0.01),
              clipBehavior: Clip.antiAlias,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          StatefulBuilder(builder: (context,state){
                            return Ink.image(
                            onImageError: (context,onImageError){
                                  isErrorImage = true;
                                  state((){});
                              },
                            image: isErrorImage ? AssetImage(largeIcon) as ImageProvider : CachedNetworkImageProvider(
                                widget.reportModel.imageUrl.toString()),
                            child: InkWell(
                              onTap: () {
                                BasicUtils.openUrl(widget.reportModel.url);
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
                              widget.reportModel.title.toString(),
                              style: GoogleFonts.abel(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.reportModel.newsSite,
                          style: GoogleFonts.abel(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
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
                                  padding: const EdgeInsets.only(bottom:5.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Published at',
                                      style: GoogleFonts.abel(
                                        color: Colors.grey
                                      ),
                                    )),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today_outlined),
                                    Text(widget.reportModel.publishedAt.substring(0,10),
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:8.0,bottom: 8.0),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.watch_outlined),
                                    Text(widget.reportModel.publishedAt.substring(11,16),
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
                                  padding: const EdgeInsets.only(bottom:5.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Updated at',
                                      style: GoogleFonts.abel(
                                        color: Colors.grey
                                      ),
                                    )),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today_outlined),
                                    Text(widget.reportModel.updatedAt.substring(0,10),
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top:8.0,bottom: 8.0),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.watch_outlined),
                                    Text(widget.reportModel.updatedAt.substring(11,16),
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
                          child: buildText(widget.reportModel.summary)),
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
        ));
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
