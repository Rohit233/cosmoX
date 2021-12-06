import 'package:cosmox/Services/report_services.dart';
import 'package:cosmox/models/report_model.dart';
import 'package:cosmox/utils/BasicUtils.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:cosmox/widgets/app_bar.dart';
import 'package:cosmox/widgets/report_card.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  var listState, appBarState;
  bool isScrollingDown = false;
  ScrollController scrollController = ScrollController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  List<ReportModel> listReport = [];
  Future<List<ReportModel>> fetchReport() async {
    return await ReportServices().getReport();
  }

 resetPaginationStatus(){
    ReportServices.limit = 50;
    ReportServices.start = 0;
 }

  @override
  void initState() {
    resetPaginationStatus();
    scrollController.addListener(() {
      if (BasicUtils.isEndOfFeed(scrollController)) {
        if (!isLoading.value) {
          isLoading.value = true;
          fetchReport().then((value) {
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            StatefulBuilder(builder: (context, state) {
              appBarState = state;
              return AppBarWidget(
                title: 'ISS report',
                isScrollingDown: isScrollingDown,
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async{
                   isLoading.value = true;
                   resetPaginationStatus();
                   listReport = [];
                   listState((){});
                   listReport = await fetchReport(); 
                   listState((){});
                   isLoading.value = false;
                },
                child: FutureBuilder(
                    future: fetchReport(),
                    builder:
                        (context, AsyncSnapshot<List<ReportModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,int i){
                              return BasicUtils.loadingCard(context);
                            });
                      }
                      listReport = snapshot.data ?? [];
                      return listReport.isEmpty
                          ? Center(
                              child: Text('No report found'),
                            )
                          : StatefulBuilder(builder: (context, state) {
                              listState = state;
                              return listReport.isEmpty && isLoading.value ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,int i){
                              return BasicUtils.loadingCard(context);
                            }) : ListView.builder(
                                controller: scrollController,
                                itemCount: listReport.length,
                                itemBuilder: (context, int i) {
                                  ReportModel report = listReport[i];
                                  return Column(
                                    children: [
                                      ReportCard(
                                        reportModel: report,
                                      ),
                                      ValueListenableBuilder(
                                        valueListenable: isLoading,
                                        builder:
                                            (context, bool isLoading, child) {
                                          return i == listReport.length - 1 &&
                                                  isLoading
                                              ? Center(
                                                  child:
                                                      circularProgressIndicator,
                                                )
                                              : Container();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
