import 'package:cosmox/pages/article.dart';
import 'package:cosmox/pages/astronomy_posts.dart';
import 'package:cosmox/pages/iss_location.dart';
import 'package:cosmox/pages/spacex_launches.dart';
import 'package:cosmox/utils/IconUtils.dart';
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
        icon: Icon(IconUtils.astronomyPostIcon,size:28,),
        label: 'Astronomy'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.article_outlined,size:28,),
        label: 'Articles'
      ),
      BottomNavigationBarItem(
        icon: Icon(IconUtils.launchesIcon,size:28,),
        label: 'SpaceX launches'
      ),
      BottomNavigationBarItem(
        icon: Icon(IconUtils.issIcon,size:28),
        label: 'ISS'
      )
    ];
  }
  List<Widget> tabsContent(){
    return [
      AstronomyPosts(),
      Article(),
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