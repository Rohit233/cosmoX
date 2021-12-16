import 'package:cached_network_image/cached_network_image.dart';
import 'package:cosmox/models/spacex_launches_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/DateTimeUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:flutter/material.dart';

import 'package:cosmox/widgets/launch_details.dart';

class LaunchesCard extends StatefulWidget {
  final SpaceXLaunchesModel spaceXLaunchesModel;
  const LaunchesCard({Key? key, required this.spaceXLaunchesModel})
      : super(key: key);

  @override
  _LaunchesCardState createState() => _LaunchesCardState();
}

class _LaunchesCardState extends State<LaunchesCard> {
  bool isImageLoadingFailed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (ListTile(
        onTap: () {
          BasicUtils.openBottomSheet(context, (scrollController){
             return LauchDetail(spaceXLaunchesModel: widget.spaceXLaunchesModel);
          }, null);
        },
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 23,
            foregroundImage: widget.spaceXLaunchesModel.smallIcon == null
                ? AssetImage(smallIcon)
                : isImageLoadingFailed ? AssetImage(smallIcon) as ImageProvider : CachedNetworkImageProvider(widget.spaceXLaunchesModel.smallIcon!,
                    errorListener: (){
                      setState(() {
                         isImageLoadingFailed = true;                

                      });
                    }
                ),
          ),
        ),
        title: Text(widget.spaceXLaunchesModel.name ?? "",style: textStyle,),
        subtitle: Text(DateTimeUtils.getFormatedDateTimeFromEpoch(
            (widget.spaceXLaunchesModel.dateInUnix! * 1000)),style: textStyle,),
      )),
    );
  }
}
