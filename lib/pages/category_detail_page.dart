import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ty/model/bean/category_bean.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/model/discovery_model.dart';
import 'package:ty/pages/video_detail_page.dart';
import 'package:ty/utils/color_util.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/string_util.dart';
import 'package:ty/utils/toast_util.dart';
import 'package:ty/widget/loading_container.dart';

///分类详情列表页
class CategoryDetailPage extends StatefulWidget {
  final CategoryBean categoryBean;

  CategoryDetailPage(this.categoryBean);

  @override
  State<StatefulWidget> createState() => CategoryDetailPageState(categoryBean);
}

class CategoryDetailPageState extends State<CategoryDetailPage> {
  final CategoryBean categoryBean;
  DiscoveryModel discoveryModel = DiscoveryModel();
  bool _isLoading = true;
  bool _isLoadMore = false;
  String nextPageUrl = "";
  List<Item> videoItems = [];
  ScrollController _scrollController;
  Color _swatchColor = Colors.white;

  //AppBar高度
  double appBarHeight;

  //悬浮按钮默认偏移量
  double fabDy;
  Offset fabOffset; //悬浮按钮偏移量
  double fabScale = 1.0; //悬浮按钮缩放量
  double headDescOffsetDy = 0; //头部描述偏移量

  CategoryDetailPageState(this.categoryBean) : super() {
    double windowTop = MediaQueryData.fromWindow(window).padding.top;
    appBarHeight = 260 - windowTop;
    fabDy = appBarHeight + windowTop;
  }

  @override
  void initState() {
    super.initState();
    fabOffset = Offset(0, fabDy);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          //计算悬浮按钮缩放量
          fabScale = _calFabScale(_scrollController.offset);
          //计算悬浮按钮偏移量
          fabOffset = Offset(0, fabDy - _scrollController.offset);
          //计算头部描述偏移量
          headDescOffsetDy = -(_scrollController.offset / 2);
          //计算 Title 和 返回按钮过渡颜色
          double franch = _scrollController.offset /
              _scrollController.position.maxScrollExtent;
          _swatchColor =
              ColorUtil.caculateColor(Colors.white, Colors.black, franch);
        });
      });

    discoveryModel.getCategoryDetailList(categoryBean.id).then((result) {
      nextPageUrl = result.nextPageUrl;
      setState(() {
        _isLoading = false;
        videoItems = result.itemList;
      });
    }).catchError((e) {
      MLog.log(e);
      JudyToast.showToast("加载分类列表数据出错！");
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(fabOffset.dx, fabOffset.dy)
              ..scale(fabScale, fabScale),
            child: FloatingActionButton(
              backgroundColor: Color(0xffef5362),
              child: Image.asset("images/ic_action_share.png",
                  width: 24, height: 24),
              onPressed: () {
                JudyToast.showToast("分享");
              },
            )),
        body: LoadingContainer(
            isLoading: _isLoading,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                      leading: BackButton(
                        color: _swatchColor,
                      ),
                      backgroundColor: Color(0xccffffff),
                      expandedHeight: appBarHeight,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                          title: Text(categoryBean.name,
                              style: TextStyle(color: _swatchColor)),
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              FadeInImage.assetNetwork(
                                  placeholder: "images/placeholder_banner.png",
                                  image: categoryBean.headerImage,
                                  fit: BoxFit.fill),
                              Center(
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..translate(0.0, headDescOffsetDy),
                                  child: Text(
                                    "#${categoryBean.description}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              )
                            ],
                          )))
                ];
              },
              body: NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.depth == 0) {
                      if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent) {
                        _loadMore();
                      }
                    }

                    return true;
                  },
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: videoItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildItem(context, index);
                      })),
            )));
  }

  ///构建分类 Item
  Widget _buildItem(BuildContext context, int index) {
    Item item = videoItems[index];
    Data data = item.data;

    // 格式化时间
    String timeFormat = StringUtil.durationFormat(data.duration);
    String tag = "#${data.category}/$timeFormat";

    return GestureDetector(
      onTap: () {
        VideoDetailPage.pushPage(context, item);
      },
      child: Container(
        height: 250,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: "images/placeholder_banner.png",
              image: data.cover.feed,
              fit: BoxFit.fill,
            ),
            Container(decoration: BoxDecoration(color: Color(0x50000000))),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(data.title,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                Text(tag, style: TextStyle(fontSize: 12, color: Colors.white))
              ],
            ))
          ],
        ),
      ),
    );
  }

  ///加载更多分类
  void _loadMore() {
    if (!_isLoadMore) {
      _isLoadMore = true;
      discoveryModel.getMoreCategoryData(nextPageUrl).then((result) {
        _isLoadMore = false;
        nextPageUrl = result.nextPageUrl;
        setState(() {
          videoItems.addAll(result.itemList);
        });
      }).catchError((e) {
        _isLoadMore = false;
        MLog.log(e);
        JudyToast.showToast("加载更新分类列表数据出错！");
      });
    }
  }

  ///计算悬浮按钮缩放比例
  double _calFabScale(double offsetDy) {
    double startDy = 100;
    double endDy = 130;

    if (offsetDy < startDy) {
      return 1;
    } else if (offsetDy > endDy) {
      return 0;
    } else {
      return 1.0 - (offsetDy - startDy) / 30;
    }
  }
}
