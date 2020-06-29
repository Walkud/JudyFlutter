import 'package:flutter/material.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/model/search_model.dart';
import 'package:ty/pages/video_detail_page.dart';
import 'package:ty/utils/loading_dialog.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/string_util.dart';
import 'package:ty/utils/toast_util.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final SearchModel searchModel = new SearchModel();
  List<String> hotWords = [];
  bool _isQueryData = false;
  bool _isLoadMore = false;
  TextEditingController _controller;
  List<Item> items = [];
  String nextPageUrl;
  int _total = 0;

  OutlineInputBorder inputBorder = OutlineInputBorder(
      /*边角*/
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    searchModel.getHotWord().then((result) {
      setState(() {
        hotWords = result;
      });
    }).catchError((e) {
      MLog.log(e);
      JudyToast.showToast("加载热门关键词数据出错！");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 40, top: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 30),
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(fontSize: 12),
                          textInputAction: TextInputAction.search,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            querySearchResult();
                          },
                          decoration: InputDecoration(
                              fillColor: Color(0xffdddddd),
                              filled: true,
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Icon(
                                  Icons.search,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              prefixIconConstraints:
                                  BoxConstraints(maxWidth: 30),
                              hintText: "帮你找到感兴趣的视频"),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.maybePop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text("取消",
                            style: TextStyle(
                                color: Color(0xff9a9a9a), fontSize: 14)),
                      ),
                    )
                  ],
                )),
            Expanded(child: getMiddeWidget())
          ],
        ),
      ),
    );
  }

  Widget getMiddeWidget() {
    if (_isQueryData) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              "-「${_controller.text}」搜索结果共$_total个-",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: NotificationListener(
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
                  //刷新组件
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildContentItem(context, index);
                      }))),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 40),
            child: Text(
              "输入标题或描述中的关键词找到更多视频",
              style: TextStyle(fontSize: 12, color: Color(0xff9a9a9a)),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "- 热门搜索词 -",
                style: TextStyle(fontSize: 14, color: Colors.black),
              )),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 3),
                  itemCount: hotWords.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildHotWordItem(context, index);
                  })),
        ],
      );
    }
  }

  Widget _buildHotWordItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.text = hotWords[index];
          querySearchResult();
        });
      },
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xffaaaaaa), borderRadius: BorderRadius.circular(3)),
          padding: EdgeInsets.all(5),
          child: Text(
            hotWords[index],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
    );
  }

  Widget _buildContentItem(BuildContext context, int index) {
    Item item = items[index];
    String timeFormat = StringUtil.durationFormat(item.data.duration);
    String subTag = "#${item.data.category}/$timeFormat";

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
                image: item.data.cover.feed,
                fit: BoxFit.fill,
              ),
              Container(decoration: BoxDecoration(color: Color(0x55000000))),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(item.data.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                  ),
                  Text(subTag,
                      style: TextStyle(fontSize: 12, color: Colors.white))
                ],
              ))
            ],
          ),
        ));
  }

  void querySearchResult() {
    LoadingDialog.show(context);
    String words = _controller.text;
    searchModel.getSearchData(words).then((result) {
      LoadingDialog.dismiss(context);
      setState(() {
        _isQueryData = true;
        _total = result.total;
        nextPageUrl = result.nextPageUrl;
        items = result.itemList;
      });
    }).catchError((e) {
      MLog.log(e);
      JudyToast.showToast("加载搜索数据出错！");
    });
  }

  void _loadMore() {
    if (!_isLoadMore) {
      _isLoadMore = true;

      searchModel.getSearchIssueData(nextPageUrl).then((result) {
        _isLoadMore = false;
        setState(() {
          nextPageUrl = result.nextPageUrl;
          items.addAll(result.itemList);
        });
      }).catchError((e) {
        _isLoadMore = false;
        MLog.log(e);
        JudyToast.showToast("加载更多数据出错！");
      });
    }
  }
}
