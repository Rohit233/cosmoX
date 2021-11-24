import 'package:flutter/material.dart';
class AppBarWidget extends StatefulWidget {
  final String title;
  final bool isScrollingDown;
  const AppBarWidget({ Key? key,required this.title,required this.isScrollingDown }) : super(key: key);

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
              title: Text(widget.title),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(100))),
            ),
          );
  }
}