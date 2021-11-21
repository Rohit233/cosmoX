import 'dart:async';

import 'package:cosmox/Services/iss_location_services.dart';
import 'package:cosmox/models/iss_location_model.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class IssLocation extends StatefulWidget {
  const IssLocation({Key? key}) : super(key: key);

  @override
  _IssLocationState createState() => _IssLocationState();
}

class _IssLocationState extends State<IssLocation> {
  late Timer timer;
  MapController mapController = MapController();
  bool isLoading = false;
  late IssLocationModel issLocationModel;
  IssLocationService issLocationService = IssLocationService();
  onMapReady() {
    mapController.onReady.then((value) {
      mapController.move(
        LatLng(issLocationModel.latitude, issLocationModel.longitude),
        5.0,
      );
    });
  }

  @override
  void initState() {
    onMapReady();
    isLoading = true;
    setState(() {});
    issLocationService.getLocationIss().then((value) {
      issLocationModel = value!;
      isLoading = false;
      setState(() {});
      timer = Timer.periodic(Duration(seconds: 5), (timer) {
        issLocationService.getLocationIss().then((value) {
          if (currentTab.value == 2) {
            issLocationModel = value!;
            setState(() {});
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: circularProgressIndicator,
          )
        : Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  maxZoom: 25,
                  minZoom: 2,
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(issLocationModel.latitude,
                            issLocationModel.longitude),
                        builder: (ctx) => Container(
                          child: Image(
                            image: AssetImage('assets/images/ISS.png'),
                          ),
                        ),
                      ),
                     userLocationData.latitude != null && userLocationData.longitude != null ? Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(userLocationData.latitude!,userLocationData.longitude!),
                        builder: (ctx) => Container(
                          child: Image(
                            image: AssetImage('assets/images/location.png'),
                          ),
                        ),
                      ) : Marker(point: LatLng(-51.0,54), builder: (ctx)=> Container()),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    icon: Icon(Icons.location_searching),
                    onPressed: () {
                      IssLocationService()
                          .getUsersLocation(context)
                          .then((value) {
                        if (value != null) {
                          mapController.move(
                              LatLng(value.latitude!, value.longitude!), 5);
                          userLocationData = value;    
                          setState(() {});
                        }
                      });
                    }),
              )
            ],
          );
  }
}
