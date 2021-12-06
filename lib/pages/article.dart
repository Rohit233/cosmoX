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
  var listState, appBarState;
  bool isScrollingDown = false;
  List<ArticleModel> listArticles = [];

  Future<List<ArticleModel>> fetchArticles() async {
    return await ArticleServices().getListArticle();
  }

  resetPaginationStatus(){
    ArticleServices.limit = 50;
    ArticleServices.start = 0;
  }

  @override
  void initState() {
    resetPaginationStatus();
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
          StatefulBuilder(builder: (context, state) {
            appBarState = state;
            return AppBarWidget(
                title: 'Articles', isScrollingDown: isScrollingDown);
          }),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                isLoading.value = true;
                listArticles = [];
                resetPaginationStatus();
                listState(() {});
                listArticles = await fetchArticles();
                isLoading.value = false;
                listState(() {});
              },
              child: FutureBuilder(
                  future: fetchArticles(),
                  builder:
                      (context, AsyncSnapshot<List<ArticleModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,int i){
                              return BasicUtils.loadingCard(context);
                            });
                    }
                    listArticles = snapshot.data ?? [];
                    return Container(
                      child: StatefulBuilder(
                        builder: (context, state) {
                          listState = state;
                          return listArticles.isEmpty && isLoading.value ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,int i){
                              return BasicUtils.loadingCard(context);
                            }) : ListView.builder(
                            controller: scrollController,
                            itemCount: listArticles.length,
                            itemBuilder: (context, int i) {
                              return Column(
                                children: [
                                  ArticleCard(articleModel: listArticles[i]),
                                  ValueListenableBuilder(
                                    valueListenable: isLoading,
                                    builder: (context, bool isLoading, child) {
                                      return isLoading &&
                                              i == listArticles.length - 1
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
          ),
        ],
      ),
    );
  }
}
