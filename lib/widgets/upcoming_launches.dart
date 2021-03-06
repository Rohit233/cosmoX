import 'package:cosmox/Services/spacex_launchesService.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
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
        builder: (context, AsyncSnapshot<List<SpaceXLaunchesModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,int i){
                return ListTile(
                  leading: BasicUtils.loadingShimmer(child: CircleAvatar()),
                  title: BasicUtils.loadingShimmer(height: 15,width: 150),
                );
              }
            );
          }
          return snapshot.data == null
              ? Container(
                  child: Center(child: Text('No launch data found')),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, int i) {
                    return LaunchesCard(spaceXLaunchesModel: snapshot.data![i]);
                  },
                );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
