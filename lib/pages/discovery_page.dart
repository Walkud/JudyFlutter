import 'package:flutter/material.dart';
import 'package:ty/pages/discovery_category_page.dart';
import 'package:ty/pages/discovery_follow_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoveryPageState();
}

class DiscoveryPageState extends State<DiscoveryPage>
    with AutomaticKeepAliveClientMixin {
  final List<String> _tabValues = ["关注", "分类"];
  final List<StatefulWidget> _tabView = [
    DiscoveryFollowPage(),
    DiscoveryCategoryPage()
  ];

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _tabValues.length,
      vsync: ScrollableState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "发现",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
                tabs: _tabValues.map((name) {
                  return Container(
                      padding: EdgeInsets.only(bottom: 8, top: 8),
                      child: Text(name, style: TextStyle(fontSize: 14)));
                }).toList(),
                controller: _controller,
                indicatorPadding: EdgeInsets.only(left: 50, right: 50, top: 0),
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.black,
                unselectedLabelColor: Color(0x55000000))),
        body: TabBarView(
          controller: _controller,
          children: _tabView,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
