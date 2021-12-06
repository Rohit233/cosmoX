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
        backgroundColor: Colors.black54,
        title: Text(widget.title, style: GoogleFonts.titanOne(fontSize: 20)),
        shadowColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
    );
  }
}
