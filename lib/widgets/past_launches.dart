import 'package:cosmox/Services/spacex_launchesService.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/widgets/launches_card_list.dart';
import 'package:flutter/material.dart';
class PastLaunches extends StatefulWidget {
  const PastLaunches({ Key? key }) : super(key: key);

  @override
  _PastLaunchesState createState() => _PastLaunchesState();
}


class _PastLaunchesState extends State<PastLaunches> with AutomaticKeepAliveClientMixin {
Future<List<SpaceXLaunchesModel>?> fetchPastLaunches() async {
  return await SpaceXLaunchesService().pastLaunches();  
}
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: FutureBuilder(
        future: fetchPastLaunches(),
        builder: (context,AsyncSnapshot<List<SpaceXLaunchesModel>?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data == null ? Container(
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