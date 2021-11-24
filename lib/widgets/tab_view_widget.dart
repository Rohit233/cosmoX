import 'package:cosmox/Services/iss_location_services.dart';
import 'package:cosmox/utils/globalUtils.dart';
import 'package:flutter/material.dart';

class TabViewWidget extends StatefulWidget {
  final List<BottomNavigationBarItem> allTabs;
  final List<Widget> tabsContent;
  final bool isTabBarOnTop;
  const TabViewWidget(
      {Key? key,
      required this.allTabs,
      required this.tabsContent,
      this.isTabBarOnTop = false})
      : super(key: key);

  @override
  _TabViewWidgetState createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: currentTab,
          builder: (context, int current, child) {
            if (current == 3) {
              IssLocationService().getUsersLocation(context).then((value) {
                 if(value != null){
                   userLocationData = value;
                 }
                  
              });
            }
            return BottomNavigationBar(
                currentIndex: current,
                selectedFontSize: 14,
                onTap: (int index) {
                  currentTab.value = index;
                },
                items: widget.allTabs);
          }),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    for (int i = 0; i < widget.tabsContent.length; i++)
                      buildOffStageWidget(i)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOffStageWidget(int index) {
    return ValueListenableBuilder(
        valueListenable: currentTab,
        builder: (context, int currentTab, child) {
          return Offstage(
            offstage: currentTab != index,
            child: widget.tabsContent[index],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
