import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmox/Services/spacex_launchesService.dart';
import 'package:cosmox/models/launchpad_model.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/pages/spacex_launches.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:flutter/material.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:shimmer/shimmer.dart';

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
                child: Text(widget.spaceXLaunchesModel.dateInUnix.toString()),
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
                leading: CircleAvatar(
                  foregroundImage: CachedNetworkImageProvider(
                      widget.spaceXLaunchesModel.smallIcon ?? ''),
                ),
                title: Text(
                  widget.spaceXLaunchesModel.name ?? "",
                  textAlign: TextAlign.justify,
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        Padding(padding: EdgeInsets.only(left: 5)),
                        Text(DateTimeUtils.getFormatedDateFromEpoch(
                            widget.spaceXLaunchesModel.dateInUnix! * 1000))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          FutureBuilder<LaunchPadModel>(
                              future: SpaceXLaunchesService().getLaunchPadById(
                                  widget.spaceXLaunchesModel.launchePad!),
                              builder: (context,
                                  AsyncSnapshot<LaunchPadModel> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox(
                                    width: 80,
                                    height: 15,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.black38,
                                      highlightColor: Colors.grey,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4.0)
                                        ),
                                        width: double.infinity,
                                        height: 50,
                                      ),
                                    ),
                                  );
                                }
                                return Text(snapshot.data!.locality ??
                                    'Location not available');
                              })
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    widget.spaceXLaunchesModel.details ?? 'No details found'),
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
