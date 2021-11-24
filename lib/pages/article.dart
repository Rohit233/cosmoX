import 'package:cosmox/Services/article_services.dart';
import 'package:cosmox/models/article_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:cosmox/widgets/app_bar.dart';
import 'package:cosmox/widgets/article_card.dart';
import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  const Article({Key? key}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  var listState,appBarState;
  bool isScrollingDown = false;

  Future<List<ArticleModel>> fetchArticles() async {
    return await ArticleServices().getListArticle();
  }

  @override
  void initState() {
    ArticleServices.limit = 50;
    ArticleServices.start = 0;
    scrollController.addListener(() {
      if (BasicUtils.isEndOfFeed(scrollController)) {
        if (!isLoading.value) {
          isLoading.value = true;
          fetchArticles().then((value) {
            isLoading.value = false;
            listState(() {});
          });
        }
      }
      appBarState(() {
       isScrollingDown = BasicUtils.checkScrollingState(scrollController);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          StatefulBuilder(
            builder: (context, state) {
              appBarState = state;
              return AppBarWidget(title: 'Articles', isScrollingDown: isScrollingDown);
            }
          ),
          Expanded(
            child: FutureBuilder(
                future: fetchArticles(),
                builder: (context, AsyncSnapshot<List<ArticleModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: circularProgressIndicator,
                    );
                  }
                  return Container(
                    child: StatefulBuilder(
                      builder: (context, state) {
                        listState = state;
                        List<ArticleModel> listArticle = snapshot.data ?? [];
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: listArticle.length,
                          itemBuilder: (context, int i) {
                            return Column(
                              children: [
                                ArticleCard(articleModel: listArticle[i]),
                                ValueListenableBuilder(
                                  valueListenable: isLoading,
                                  builder: (context, bool isLoading, child) {
                                    return isLoading &&
                                            i == listArticle.length - 1
                                        ? circularProgressIndicator
                                        : Container();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
