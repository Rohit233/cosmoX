import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cosmox/Services/spacex_launchesService.dart';
import 'package:cosmox/models/launchpad_model.dart';
import 'package:cosmox/models/payload_model.dart';
import 'package:cosmox/models/rocket_model.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:cosmox/widgets/autoPhotoScroll.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class LauchDetail extends StatefulWidget {
  final SpaceXLaunchesModel spaceXLaunchesModel;
  const LauchDetail({Key? key, required this.spaceXLaunchesModel})
      : super(key: key);

  @override
  _LauchDetailState createState() => _LauchDetailState();
}

class _LauchDetailState extends State<LauchDetail> {
  TextStyle headingTextStyle = GoogleFonts.abel(
    fontSize: 22
  );
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
                future: SpaceXLaunchesService()
                    .getRocketById(widget.spaceXLaunchesModel.rocket!),
                builder: (BuildContext context,
                    AsyncSnapshot<RocketModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return BasicUtils.loadingShimmer(
                        width: double.infinity, height: 150);
                  }
                  return FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(widget.spaceXLaunchesModel.name ?? "",style: headingTextStyle,),
                      background: snapshot.data!.flickrImages.isEmpty
                          ? Center(
                              child: Text("Photos not available"),
                            )
                          : AutoPhotoScroll(
                              listPhoto: snapshot.data!.flickrImages));
                }),
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
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            onTap: widget.spaceXLaunchesModel.wikipedia != null
                ? () {
                    BasicUtils.openUrl(widget.spaceXLaunchesModel.wikipedia!);
                  }
                : null,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        foregroundImage: widget.spaceXLaunchesModel.smallIcon == null ? AssetImage(smallIcon) as ImageProvider 
                        : CachedNetworkImageProvider(
                            widget.spaceXLaunchesModel.smallIcon ?? ''),
                      ),
                      title: Text(
                        widget.spaceXLaunchesModel.name ?? "",
                        textAlign: TextAlign.justify,
                        style: textStyle,
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              Padding(padding: EdgeInsets.only(left: 5)),
                              Text(DateTimeUtils.getFormatedDateFromEpoch(
                                  widget.spaceXLaunchesModel.dateInUnix! *
                                      1000),style: textStyle,)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on),
                                FutureBuilder<LaunchPadModel>(
                                    future: SpaceXLaunchesService()
                                        .getLaunchPadById(widget
                                            .spaceXLaunchesModel.launchePad!),
                                    builder: (context,
                                        AsyncSnapshot<LaunchPadModel>
                                            snapshot) {
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
                                                      BorderRadius.circular(
                                                          4.0)),
                                              width: double.infinity,
                                              height: 50,
                                            ),
                                          ),
                                        );
                                      }
                                      return Text(snapshot.data!.locality ??
                                          'Location not available',style: textStyle,);
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(widget.spaceXLaunchesModel.details ??
                          'No details found',style: textStyle,),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.spaceXLaunchesModel.webcast == null
                          ? Container()
                          : IconButton(
                            iconSize: 21,
                            onPressed: () {
                              BasicUtils.openUrl(
                                  widget.spaceXLaunchesModel.webcast!);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.youtube,
                              color: Colors.red,
                            ),
                          ),
                    widget.spaceXLaunchesModel.article == null ? Container() : IconButton(
                       icon: FaIcon(FontAwesomeIcons.blogger),
                       onPressed: (){
                          if(widget.spaceXLaunchesModel.article != null){
                             BasicUtils.openUrl(widget.spaceXLaunchesModel.article!);
                          }
                       }),

                     widget.spaceXLaunchesModel.reddit!.campaign == null 
                     && widget.spaceXLaunchesModel.reddit!.launch == null 
                     && widget.spaceXLaunchesModel.reddit!.recovery == null 
                     ? Container()
                      :  IconButton(
                          iconSize: 21,
                          icon: FaIcon(FontAwesomeIcons.redditSquare,color:Colors.orange),
                          onPressed: () {
                            SpaceXLaunchesService.alertDialog(context,widget.spaceXLaunchesModel);
                          })
                    ],
                  ),
                )
              ],
            ),
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
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom:5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Rocket",
                      style: headingTextStyle,
                    ),
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
                              child: Text('No rocket data found',style: textStyle,),
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
                                          Text('Model',style: textStyle,),
                                          Text(rocketModel.name ?? 'Unknown',style: textStyle,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Static fire',style: textStyle,),
                                          Text(widget.spaceXLaunchesModel
                                                      .staticFireDateUnix ==
                                                  null
                                              ? 'Unknown'
                                              : DateTimeUtils
                                                  .getFormatedDateTimeFromEpoch(
                                                      widget.spaceXLaunchesModel
                                                              .staticFireDateUnix! *
                                                          1000),style: textStyle,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Stages',style: textStyle,),
                                          Text(rocketModel.stages == null
                                              ? 'Unknow'
                                              : rocketModel.stages.toString(),style: textStyle,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Reused(First Stage)',style: textStyle,),
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
                                          Text('Reused(Second Stage)',style: textStyle,),
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
                                          Text('Boosters',style: textStyle,),
                                          Text(rocketModel.boosters == null
                                              ? 'Unknown'
                                              : rocketModel.boosters.toString(),style: textStyle,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Country',style: textStyle,),
                                          Text(rocketModel.country == null
                                              ? 'Unknown'
                                              : rocketModel.country.toString(),style: textStyle,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('First flight',style: textStyle,),
                                          Text(rocketModel.firstFlight == null
                                              ? 'Unknown'
                                              : rocketModel.firstFlight
                                                  .toString(),style: textStyle,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Description',style: textStyle,),
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
                                              style: textStyle,
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
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  "Payloads",
                  style: headingTextStyle,
                ),
              ),
              FutureBuilder(
                future: SpaceXLaunchesService()
                    .getListPayloads(widget.spaceXLaunchesModel.payloads),
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
                  if (snapshot.data != null) {
                    listPayload = snapshot.data!;
                  }
                  return listPayload.isEmpty
                      ? Center(
                          child: Text('Payloads data not found',style: textStyle,),
                        )
                      : Padding(
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

  List<Widget> payloadDataWidget(List<PayloadModel> listPayloads) {
    return listPayloads.map((payload) {
      return Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Name',style: textStyle,), Text(payload.name ?? 'Unknown',style: textStyle,)],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Manufacturer',style: textStyle,),
                        Row(
                          children: [
                            for (var i in payload.manufacturers!) Text('$i,',style: textStyle,)
                          ],
                        )
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Customers',style: textStyle,),
                        Row(
                          children: [
                            for (var i in payload.customers!) Text('$i,',style: textStyle,)
                          ],
                        )
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nationality',style: textStyle,),
                        for (var i in payload.nationalities!) Text('$i,',style: textStyle,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('orbit',style: textStyle,),
                        Text(payload.orbit ?? 'Unknown',style: textStyle,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Periapsis',style: textStyle,),
                        Text(payload.periapsisKm == null
                            ? 'Unknown'
                            : payload.periapsisKm.toString() + ' km',style: textStyle,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Apoapsis',style: textStyle,),
                        Text(payload.apoapsisKm == null
                            ? 'Unknown'
                            : payload.apoapsisKm.toString() + ' km',style: textStyle,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Inclination',style: textStyle,),
                        Text(payload.inclinationDeg == null
                            ? 'Unknown'
                            : payload.inclinationDeg.toString() + ' degree',style: textStyle,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Period',style: textStyle,),
                        Text(payload.lifespanYears == null
                            ? 'Unknown'
                            : payload.lifespanYears.toString() + ' year',style: textStyle,)
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
