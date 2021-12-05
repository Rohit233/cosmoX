import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cosmox/Services/spacex_launchesService.dart';
import 'package:cosmox/models/launchpad_model.dart';
import 'package:cosmox/models/payload_model.dart';
import 'package:cosmox/models/rocket_model.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:cosmox/widgets/autoPhotoScroll.dart';
import 'package:flutter/material.dart';
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
            flexibleSpace: FutureBuilder(
              future: SpaceXLaunchesService().getRocketById(widget.spaceXLaunchesModel.rocket!),
              builder: (BuildContext context, AsyncSnapshot<RocketModel> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return BasicUtils.loadingShimmer(width: double.infinity, height: 150);
                }
                return FlexibleSpaceBar(
                  title: Text(widget.spaceXLaunchesModel.name ?? ""),
                  background: snapshot.data!.flickrImages.isEmpty ? Center(
                    child: Text("Photos not available"),
                  ) : AutoPhotoScroll(listPhoto: snapshot.data!.flickrImages)
                   
                );
              }
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
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
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
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Rocket",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                FutureBuilder(
                    future: SpaceXLaunchesService()
                        .getRocketById(widget.spaceXLaunchesModel.rocket!),
                    builder: (context, AsyncSnapshot<RocketModel> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            BasicUtils.loadingShimmer(width: 350, height: 50),
                            Padding(padding: EdgeInsets.only(top: 8.0)),
                            BasicUtils.loadingShimmer(width: 250, height: 20),
                            Padding(padding: EdgeInsets.only(bottom: 8.0)),
                            BasicUtils.loadingShimmer(width: 250, height: 20),
                            Padding(padding: EdgeInsets.only(bottom: 8.0)),
                          ],
                        );
                      }
                      late RocketModel? rocketModel;
                      if (snapshot.data != null) {
                        rocketModel = snapshot.data ?? null;
                      }
                      return rocketModel == null
                          ? Center(
                              child: Text('No rocket data found'),
                            )
                          : InkWell(
                              onTap: () {
                                if (rocketModel != null) {
                                  BasicUtils.openUrl(
                                      rocketModel.wikipedia.toString());
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Model'),
                                          Text(rocketModel.name ?? 'Unknown')
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Static fire'),
                                          Text(widget.spaceXLaunchesModel
                                                      .staticFireDateUnix ==
                                                  null
                                              ? 'Unknown'
                                              : DateTimeUtils
                                                  .getFormatedDateTimeFromEpoch(
                                                      widget.spaceXLaunchesModel
                                                              .staticFireDateUnix! *
                                                          1000))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Stages'),
                                          Text(rocketModel.stages == null
                                              ? 'Unknow'
                                              : rocketModel.stages.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Reused(First Stage)'),
                                          rocketModel.reusableFirstStage == null
                                              ? Icon(Icons.help_outline_sharp)
                                              : (rocketModel.reusableFirstStage!
                                                  ? Icon(
                                                      Icons
                                                          .done_outline_rounded,
                                                      color: Colors.green)
                                                  : Icon(Icons.clear,
                                                      color: Colors.redAccent))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Reused(Second Stage)'),
                                          rocketModel.reusableSecondStage ==
                                                  null
                                              ? Icon(Icons.help_outline_sharp)
                                              : (rocketModel
                                                      .reusableSecondStage!
                                                  ? Icon(
                                                      Icons
                                                          .done_outline_rounded,
                                                      color: Colors.green)
                                                  : Icon(Icons.clear,
                                                      color: Colors.redAccent))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Boosters'),
                                          Text(rocketModel.boosters == null
                                              ? 'Unknown'
                                              : rocketModel.boosters.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Country'),
                                          Text(rocketModel.country == null
                                              ? 'Unknown'
                                              : rocketModel.country.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('First flight'),
                                          Text(rocketModel.firstFlight == null
                                              ? 'Unknown'
                                              : rocketModel.firstFlight
                                                  .toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Description'),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              rocketModel.description == null
                                                  ? 'Unknown'
                                                  : rocketModel.description
                                                      .toString(),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    })
              ],
            )),
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
            children: [
              Padding(
                padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                child: Text(
                      "Payloads",
                      style: TextStyle(fontSize: 20),
                    ),
              ),
              FutureBuilder(
                future: SpaceXLaunchesService().getListPayloads(widget.spaceXLaunchesModel.payloads),
                builder: (context, AsyncSnapshot<List<PayloadModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        BasicUtils.loadingShimmer(width: 350, height: 50),
                        Padding(padding: EdgeInsets.only(top: 8.0)),
                        BasicUtils.loadingShimmer(width: 250, height: 20),
                        Padding(padding: EdgeInsets.only(bottom: 8.0)),
                        BasicUtils.loadingShimmer(width: 250, height: 20),
                        Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      ],
                    );
                  }
                 late List<PayloadModel> listPayload;
                 if(snapshot.data != null){
                   listPayload = snapshot.data!;
                 }
                  return listPayload.isEmpty ? Center(
                    child: Text('Payloads data not found'),
                  ) : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CarouselSlider(
                         items: payloadDataWidget(listPayload),
                         options: CarouselOptions(
                           viewportFraction: 1.0,
                           aspectRatio: 1,
                           initialPage: 0,
                           enableInfiniteScroll: false,
                         ))
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> payloadDataWidget(List<PayloadModel> listPayloads){
    return listPayloads.map((payload){
        return Builder(
          builder: (context){
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name'),
                          Text(payload.name ?? 'Unknown')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Manufacturer'),
                          for(var i in payload.manufacturers!)
                            Text('$i,')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Customers'),
                          for(var i in payload.customers!)
                            Text('$i,')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nationality'),
                          for(var i in payload.nationalities!)
                            Text('$i,')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('orbit'),
                          Text(payload.orbit ?? 'Unknown')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Periapsis'),
                          Text(payload.periapsisKm == null ? 'Unknown' : payload.periapsisKm.toString()+' km' )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Apoapsis'),
                          Text(payload.apoapsisKm == null ? 'Unknown' : payload.apoapsisKm.toString()+' km' )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Inclination'),
                          Text(payload.inclinationDeg == null ? 'Unknown' : payload.inclinationDeg.toString()+' degree' )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Period'),
                          Text(payload.lifespanYears == null ? 'Unknown' : payload.lifespanYears.toString()+' year' )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
    }).toList();
  }
}
