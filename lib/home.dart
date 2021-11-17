import 'package:cosmox/pages/astronomy_posts.dart';
import 'package:cosmox/pages/iss_location.dart';
import 'package:cosmox/pages/spacex_launches.dart';
import 'package:cosmox/widgets/tab_view_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 List<BottomNavigationBarItem> allTabs(){
    return[
      BottomNavigationBarItem(
        icon: Icon(Icons.photo),
        label: 'Astronomy post'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.public_rounded),
        label: 'SpaceX launches'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.location_on),
        label: 'ISS location'
      )
    ];
  }
  List<Widget> tabsContent(){
    return [
      AstronomyPosts(),
      SpaceXLaunches(),
      IssLocation()
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabViewWidget(allTabs: allTabs(), tabsContent: tabsContent())
    );
  }
}