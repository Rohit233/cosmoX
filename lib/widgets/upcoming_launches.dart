import 'package:cosmox/Services/spacex_launchesService.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/widgets/launches_card_list.dart';
import 'package:flutter/material.dart';

class UpcomingLaunches extends StatefulWidget {
  const UpcomingLaunches({Key? key}) : super(key: key);

  @override
  _UpcomingLaunchesState createState() => _UpcomingLaunchesState();
}

class _UpcomingLaunchesState extends State<UpcomingLaunches>
    with AutomaticKeepAliveClientMixin {
  Future<List<SpaceXLaunchesModel>?> fetchUpcomingLaunches() async {
    return await SpaceXLaunchesService().upcommingLaunches();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        child: FutureBuilder(
          future: fetchUpcomingLaunches(),
          builder: (context,AsyncSnapshot<List<SpaceXLaunchesModel>?> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            return snapshot.data == null && snapshot.data!.isEmpty ? Container(
              child: Center(child: Text('No launch data found')),
            ) :  ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context,int i){
                return LaunchesCard(spaceXLaunchesModel: snapshot.data![i]);
              },
            );
          },
        ) ,
        );
  }

  @override
  bool get wantKeepAlive => true;
}