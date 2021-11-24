import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/pages/spacex_launches.dart';
import 'package:flutter/material.dart';
import 'package:cosmox/models/spacex_launches_model.dart';

class LauchDetail extends StatefulWidget {
  final SpaceXLaunchesModel spaceXLaunchesModel;
  const LauchDetail({Key? key, required this.spaceXLaunchesModel})
      : super(key: key);

  @override
  _LauchDetailState createState() => _LauchDetailState();
}

class _LauchDetailState extends State<LauchDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.spaceXLaunchesModel.name ?? ""),
              background: FlutterLogo(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text(
                    widget.spaceXLaunchesModel.dateInUnix.toString() ?? ""),
              ),
            ),
          ),
          SliverSafeArea(
              top: false,
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    _missionCard(context),
                    _firstStageCard(context),
                    _secondStageCard(context)
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _missionCard(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(width: 2, color: Colors.white30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: FlutterLogo(),
                title: Text(widget.spaceXLaunchesModel.name ?? ""),
                subtitle: Row(
                  children: [
                    FlutterLogo(),
                    Text(widget.spaceXLaunchesModel.staticFireDateUnix
                        .toString())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstStageCard(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(width: 2, color: Colors.white30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: ListTile(
                  title: Text("Rocket"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _secondStageCard(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(width: 2, color: Colors.white30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: ListTile(
                  title: Text("Payload"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
