import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              onSelected: (String value) {
                if (value == 'privacy') {
                  BasicUtils.openUrl(
                      'https://sites.google.com/view/cosmox-privacypolicy/home');
                }
                if (value == 'about') {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            title: Center(
                                child: Text('Developers',
                                    style: GoogleFonts.abel(fontSize: 35))),
                            content: SingleChildScrollView(
                              child: Center(
                                  child: Column(
                                children: [
                                  Center(
                                      child: Text(
                                    'Rohit Lokhande',
                                    style: GoogleFonts.abel(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Text(
                                    'Flutter Developer',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.github),
                                              onPressed: () {
                                                BasicUtils.openUrl(
                                                    'https://github.com/Rohit233');
                                              }),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.linkedin),
                                              onPressed: () {
                                                BasicUtils.openUrl(
                                                    'https://www.linkedin.com/in/rohit-lokhande-3b15ab181');
                                              }),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.instagram),
                                              onPressed: () {
                                                BasicUtils.openUrl(
                                                    'https://instagram.com/rohitlokhande_23?utm_medium=copy_link');
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Center(
                                        child: Text(
                                      'Yash Masalge',
                                      style: GoogleFonts.abel(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Center(
                                    child: Text(
                                      'Flutter Developer',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.github),
                                              onPressed: () {
                                                BasicUtils.openUrl(
                                                    'https://github.com/yashmasalge');
                                              }),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.linkedin),
                                              onPressed: () {
                                                BasicUtils.openUrl(
                                                    'https://www.linkedin.com/in/yashmasalge/');
                                              }),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                              icon: FaIcon(
                                                  FontAwesomeIcons.instagram),
                                              onPressed: () {
                                                BasicUtils.openUrl(
                                                    'https://instagram.com/itami_uzumaki_?utm_medium=copy_link');
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      BasicUtils.openUrl(
                                          'https://github.com/Rohit233/cosmoX');
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                          left: 50,
                                          right: 50,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(32.0)),
                                        ),
                                        child: TextButton.icon(
                                            onPressed: () {
                                              BasicUtils.openUrl(
                                                  'https://github.com/Rohit233/cosmoX');
                                            },
                                            icon:
                                                FaIcon(FontAwesomeIcons.github),
                                            label: Text('Github Link'))),
                                  )
                                ],
                              )),
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () => Navigator.pop(
                                    context, true), // passing true
                                child: Text(
                                  'close',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ));
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Privacy policy'),
                      value: 'privacy',
                    ),
                    PopupMenuItem(
                      child: Text('About us'),
                      value: 'about',
                    )
                  ]),
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
