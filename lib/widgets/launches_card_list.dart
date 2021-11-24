import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:flutter/material.dart';

class LaunchesCard extends StatefulWidget {
  final SpaceXLaunchesModel spaceXLaunchesModel;
  const LaunchesCard({Key? key, required this.spaceXLaunchesModel})
      : super(key: key);

  @override
  _LaunchesCardState createState() => _LaunchesCardState();
}

class _LaunchesCardState extends State<LaunchesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color:Colors.black)
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 23,
            foregroundImage:
               widget.spaceXLaunchesModel.smallIcon == null ? null : NetworkImage(widget.spaceXLaunchesModel.smallIcon!),
          ),
        ),
        title: Text(widget.spaceXLaunchesModel.name ?? ""),
        subtitle: Text(DateTimeUtils.getFormatedDateTimeFromEpoch(
            (widget.spaceXLaunchesModel.dateInUnix! * 1000))),
      ),
    );
  }
}
