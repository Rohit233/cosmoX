import 'package:cosmox/utils/BasicUtils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatefulWidget {
  final String title;
  final bool isScrollingDown;
  const AppBarWidget(
      {Key? key, required this.title, required this.isScrollingDown})
      : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: !widget.isScrollingDown ? 56.0 : 0.0,
      duration: Duration(milliseconds: 200),
      child: AppBar(
        centerTitle: true,
        actions: [
          PopupMenuButton(
                onSelected:(int value){
                  if(value ==1){
                    BasicUtils.openUrl('https://sites.google.com/view/cosmox-privacypolicy/home');
                  }
                } ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Privacy policy'),
                    value: 1,
                  ),
                ]
            )
        ],
        backgroundColor: Colors.black54,
        title: Text(widget.title, style: GoogleFonts.abel(fontSize: 25)),
        shadowColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
    );
  }
}
