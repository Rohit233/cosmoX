import 'package:cosmox/Services/astronomy_post_services.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:cosmox/widgets/post_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class AstronomyPosts extends StatefulWidget {
  const AstronomyPosts({ Key? key }) : super(key: key);

  @override
  _AstronomyPostsState createState() => _AstronomyPostsState();
}

class _AstronomyPostsState extends State<AstronomyPosts> {
  ValueNotifier<List<AstronomyPostModel>> listAstronomyPost = ValueNotifier([]); 
  @override
    void initState() {
      AstronomyPostServices().getPostWhileScrolling().then((value){
       listAstronomyPost.value = List.from(value!);

      });
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: listAstronomyPost,
        builder: (context, List<AstronomyPostModel> listAstronomyPost,child) {
          return ListView.separated(
            itemBuilder: (context,int i){
              return PostCard(astronomyPostModel: listAstronomyPost[i]);
            },
            separatorBuilder: (context,int i){
              return Divider();
            }, itemCount: listAstronomyPost.length);
        }
      ),
    );
  }
}