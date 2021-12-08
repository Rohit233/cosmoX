import 'package:cosmox/Services/spacex_launchesService.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class LaunchTimer extends StatefulWidget {
  const LaunchTimer({Key? key}) : super(key: key);

  @override
  _LaunchTimerState createState() => _LaunchTimerState();
}

class _LaunchTimerState extends State<LaunchTimer> {
  TextStyle textStyle = TextStyle(
    fontSize: 20,
    
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: SpaceXLaunchesService().getNextLaunch(),
        builder: (context, AsyncSnapshot<SpaceXLaunchesModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return BasicUtils.loadingShimmer(
                width: double.infinity, height: 150);
          }
          return Container(
            height: 150,
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 35),
                    height: 150,
                    child: Image.asset('assets/images/spacexLogo.png')),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CountdownTimer(
                        endTime: snapshot.data!.dateInUnix! * 1000,
                        widgetBuilder: (context, time) {
                          if (time == null) {
                            return Text('Rocket Launched');
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             time.days == null ? Container() : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      time.days.toString(),
                                      style: textStyle,
                                    ),
                                    Text(
                                      'Day',
                                      style: textStyle,
                                    )
                                  ],
                                ),
                              ),
                             time.hours == null ? Container() : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      time.hours.toString(),
                                      style: textStyle,
                                    ),
                                    Text('Hour', style: textStyle,)
                                  ],
                                ),
                              ),
                             time.min == null ? Container() : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(time.min.toString(), style: textStyle,),
                                    Text('Minute', style: textStyle,)
                                  ],
                                ),
                              ),
                             time.sec == null ? Container() : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(time.sec.toString(), style: textStyle,),
                                    Text('Second', style: textStyle,)
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
