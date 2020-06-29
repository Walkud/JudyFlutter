import 'package:flutter/material.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/model/home_model.dart';
import 'package:ty/pages/video_detail_page.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/string_util.dart';
import 'package:ty/utils/toast_util.dart';
import 'package:ty/widget/loading_container.dart';
import 'package:ty/widget/module/home/home_banner.dart';
import 'package:ty/widget/module/home/home_toolbar.dart';

const double APPBAR_SCROLL_OFFSET = 230;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  HomeModel homeModel = new HomeModel();
  bool _isLoading = true;
  bool _isLoadMore = false;
  bool isLoadMoreFinished = false;
  List<Item> videoItems = [];
  HomeBean homeBean;
  ScrollController scrollController;
  HomeToolBar _homeToolBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Stack(children: <Widget>[
            RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: videoItems.length,
                  itemBuilder: (context, index) {
                    return _videoItems(index);
                  }),
            ),
            _homeToolBar
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
          _loadMore();
        }
      });
    _homeToolBar = HomeToolBar(scrollController);

    _handleRefresh();
  }

  Future<Null> _handleRefresh() async {
    try {
      homeBean = await homeModel.getFirstHomeData();
      //获取数据
      setState(() {
        videoItems = homeBean.issueList[0].itemList;
        _homeToolBar.clearTitlePosision();
        _homeToolBar.calTitlePosistion(videoItems);
        _isLoading = false;
        isLoadMoreFinished = false;
      });
    } catch (e, s) {
      MLog.log('Exception details:\n $e');
      MLog.log('Stack trace:\n $s');
      JudyToast.showToast("加载数据出错！");
      setState(() {
        _isLoading = false;
      });
    }
    return null;
  }

  void _loadMore() async {
    if (!_isLoadMore && !isLoadMoreFinished) {
      _isLoadMore = true;

      try {
        HomeBean bean = await homeModel.getMoreHomeData(homeBean.nextPageUrl);
        _isLoadMore = false;
        //获取数据
        setState(() {
          homeBean.nextPageUrl = bean.nextPageUrl;
          List<Item> itemList = bean.issueList[0].itemList;
          videoItems.addAll(itemList);
          _homeToolBar.calTitlePosistion(itemList);

          isLoadMoreFinished = StringUtil.isEmpty(bean.nextPageUrl);
        });
      } catch (e, s) {
        _isLoadMore = false;
        MLog.log('Exception details:\n $e');
        MLog.log('Stack trace:\n $s');
        JudyToast.showToast("加载数据出错！");
      }
    }
  }

  ///构建列表视频 Item
  Widget _videoItems(index) {
//    MLog.log('index:$index');
    Item item = videoItems[index];
    Widget child;
    if (item.getItemType() == Item.ITEM_TYPE_BANNER) {
      child = HomeBanner(item.data.itemList);
    } else if (item.getItemType() == Item.ITEM_TYPE_TEXT_HEADER) {
      //列表 Title Item
      child = Container(
//          key: anchorKey,
          height: 50,
          color: Color(0xccffffff),
          alignment: Alignment.center,
          child: Text(
            item.data.text,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ));
    } else {
      //列表视频 Item
      Image avatarImage;
      String avatar = item.data?.author?.icon;
      if (StringUtil.isEmpty(avatar)) {
        avatarImage =
            Image.asset("images/default_avatar.png", width: 40, height: 40);
      } else {
        avatarImage = Image.network(avatar, width: 40, height: 40);
      }

      String tagText = "#";
      //遍历标签
      item.data.tags.take(4).forEach((it) {
        tagText += "${it.name}/";
      });
      tagText += StringUtil.durationFormat(item.data.duration);

      //列表内容 Item
      child = GestureDetector(
          onTap: () {
            VideoDetailPage.pushPage(context, item);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FadeInImage.assetNetwork(
                height: 250,
                placeholder: "images/placeholder_banner.png",
                image: item.data.cover?.feed,
                fit: BoxFit.fill,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: avatarImage,
                    ),
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.data.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          tagText,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff555555)),
                        ),
                      ],
                    )),
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Center(
                      child: Text('#${item.data.category}',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xff555555))),
                    )
                  ],
                ),
              ),
              Divider(height: 0.5, color: Color(0xffaaaaaa))
            ],
          ));
    }

    return child;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
