import 'package:cosmox/utils/globalUtils.dart';
import 'package:cosmox/widgets/launch_timer.dart';
import 'package:cosmox/widgets/past_launches.dart';
import 'package:cosmox/widgets/upcoming_launches.dart';
import 'package:flutter/material.dart';
class SpaceXLaunches extends StatefulWidget {
  const SpaceXLaunches({ Key? key }) : super(key: key);

  @override
  _SpaceXLaunchesState createState() => _SpaceXLaunchesState();
}

class _SpaceXLaunchesState extends State<SpaceXLaunches> with TickerProviderStateMixin {
  late TabController tabController;
  @override
    void initState() {
      tabController = TabController(length: 2, vsync: this);
      super.initState();
    }

 Widget tabs(){
    return TabBar(
      controller: tabController,
      tabs: [
        Tab(
          child: Text('Upcoming launches',style: textStyle,),
        ),
        Tab(
          child: Text('Past launches',style: textStyle,),
        ),
      ],
    );
  }

  Widget tabView(){
    return TabBarView(
      controller: tabController,
      children: [
        UpcomingLaunches(),
        PastLaunches(),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          LaunchTimer(),
          tabs(),
          Expanded(child: tabView())
        ],
      ),
    );
  }
}