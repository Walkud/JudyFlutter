import 'package:flutter/material.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/model/hot_model.dart';
import 'package:ty/pages/video_detail_page.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/string_util.dart';
import 'package:ty/utils/toast_util.dart';
import 'package:ty/widget/loading_container.dart';

class HotRankPage extends StatefulWidget {
  final String apiUrl;

  HotRankPage(this.apiUrl);

  @override
  State<StatefulWidget> createState() => HotRankPageState(apiUrl);
}

class HotRankPageState extends State<HotRankPage>
    with AutomaticKeepAliveClientMixin {
  HotModel hotModel = HotModel();
  final String apiUrl;
  bool _isLoading = true;
  List<Item> rankItems = [];

  HotRankPageState(this.apiUrl);

  @override
  void initState() {
    super.initState();

    hotModel.getHotRankData(apiUrl).then((result) {
      setState(() {
        _isLoading = false;
        rankItems = result.itemList;
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
    return Container(
      child: LoadingContainer(
          isLoading: _isLoading,
          child: ListView.builder(
              itemCount: rankItems.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(context, index);
              })),
    );
  }

  ///构建列表 Item
  Widget _buildItem(BuildContext context, int index) {
    Item item = rankItems[index];
    String timeFormat = StringUtil.durationFormat(item.data.duration);
    String subTag = "#${item.data.category}/$timeFormat";

    return GestureDetector(
        onTap: () {
          VideoDetailPage.pushPage(context, item);
        },
        child: Container(
          height: 250,
          child: Stack(
            children: <Widget>[
              FadeInImage.assetNetwork(
                height: 250,
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

  @override
  bool get wantKeepAlive => true;
}
