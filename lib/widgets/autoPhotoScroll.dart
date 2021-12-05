import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class AutoPhotoScroll extends StatefulWidget {
  final List listPhoto;
   AutoPhotoScroll({ Key? key,required this.listPhoto}) : super(key: key);

  @override
  _AutoPhotoScrollState createState() => _AutoPhotoScrollState();
}

class _AutoPhotoScrollState extends State<AutoPhotoScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: widget.listPhoto.map((photo){
           return Builder(builder: (context){
             return Container(
               child: Image(
                 image: CachedNetworkImageProvider(photo),
               ) ,
             );
           });
        }).toList(),
        options: CarouselOptions(
          aspectRatio: 1,
          initialPage: 0,
          viewportFraction: 1.0,
          autoPlay: true,
        )),
    );
  }
}