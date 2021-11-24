import 'package:cosmox/Services/astronomy_post_services.dart';
import 'package:cosmox/models/astronomy_post_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:cosmox/widgets/app_bar.dart';
import 'package:cosmox/widgets/post_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AstronomyPosts extends StatefulWidget {
  const AstronomyPosts({Key? key}) : super(key: key);

  @override
  _AstronomyPostsState createState() => _AstronomyPostsState();
}

class _AstronomyPostsState extends State<AstronomyPosts> {
  ValueNotifier<List<AstronomyPostModel>> listAstronomyPost = ValueNotifier([]);
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  bool isScrollingDown = false;
  fetch() async {
    isLoading.value = true;
    await AstronomyPostServices().getPostWhileScrolling().then((value) {
      listAstronomyPost.value.addAll(value!);
      listAstronomyPost.value = List.from(listAstronomyPost.value);
    });
    isLoading.value = false;
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if (BasicUtils.isEndOfFeed(scrollController)) {
        if (!isLoading.value) {
          fetch();
        }
      }
      setState(() {
        isScrollingDown = BasicUtils.checkScrollingState(scrollController);
      });
    });
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBarWidget(
              title: 'Astronomy post', isScrollingDown: isScrollingDown),
          Expanded(
            child: Container(
              child: ValueListenableBuilder(
                  valueListenable: listAstronomyPost,
                  builder: (context, List<AstronomyPostModel> listAstronomyPost,
                      child) {
                    return listAstronomyPost.isEmpty && isLoading.value
                        ? Center(
                            child: circularProgressIndicator,
                          )
                        : ListView.separated(
                            controller: scrollController,
                            itemBuilder: (context, int i) {
                              return Column(
                                children: [
                                  PostCard(
                                      astronomyPostModel: listAstronomyPost[i]),
                                  ValueListenableBuilder(
                                    valueListenable: isLoading,
                                    builder: (context, bool isLoading, child) {
                                      return isLoading &&
                                              i == listAstronomyPost.length - 1
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child:
                                                    circularProgressIndicator,
                                              ),
                                            )
                                          : Container();
                                    },
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, int i) {
                              return Container();
                            },
                            itemCount: listAstronomyPost.length);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
