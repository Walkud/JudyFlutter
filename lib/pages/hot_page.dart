import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ty/model/hot_model.dart';
import 'package:ty/utils/app_context.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/toast_util.dart';
import 'package:ty/widget/loading_container.dart';

import 'hot_rank_page.dart';

class HotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HotPageState();
}

class HotPageState extends State<HotPage> with AutomaticKeepAliveClientMixin {
  HotModel hotModel = HotModel();
  bool _isLoading = true;

  final List<String> _tabValues = [];
  final List<StatefulWidget> _tabView = [];

  TabController _controller;

  @override
  void initState() {
    super.initState();

    hotModel.getRankList().then((result) {
      setState(() {
        for (var value in result.tabInfo.tabList) {
          _tabValues.add(value.name);
          _tabView.add(HotRankPage(value.apiUrl));
        }

        _controller = TabController(
          length: _tabValues.length,
          vsync: ScrollableState(),
        );

        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });
      MLog.log(e);
      JudyToast.showToast("加载热门数据出错！");
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isShowView = !_isLoading;
    return Scaffold(
        appBar: isShowView
            ? AppBar(
                centerTitle: true,
                title: Text(
                  "热门",
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
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black,
                    unselectedLabelColor: Color(0x55000000)))
            : null,
        body: !_isLoading
            ? TabBarView(
                controller: _controller,
                children: _tabView,
              )
            : LoadingContainer(
                isLoading: _isLoading,
                child: Container(),
              ));
  }

  @override
  bool get wantKeepAlive => true;
}
