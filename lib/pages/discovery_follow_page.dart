import 'package:flutter/material.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/model/discovery_model.dart';
import 'package:ty/pages/video_detail_page.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/string_util.dart';
import 'package:ty/utils/toast_util.dart';
import 'package:ty/widget/loading_container.dart';

///发现--关注页面
class DiscoveryFollowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DiscoveryFollowPageState();
}

class DiscoveryFollowPageState extends State<DiscoveryFollowPage>
    with AutomaticKeepAliveClientMixin {
  DiscoveryModel discoveryModel = DiscoveryModel();
  bool _isLoading = true;
  bool loadMoreFinished = false; //是否完成加载更多
  List<Item> items = [];
  String nextPageUrl; //下一页Url

  @override
  void initState() {
    super.initState();

    queryFollowList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: LoadingContainer(
      isLoading: _isLoading,
      child: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
              //加载更多
              _loadMore();
            }

            return true;
          },
          child: ListView.separated(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(context, index);
            },
            separatorBuilder: (BuildContext context, int index) {
              //分割线
              return Container(
                child: Divider(height: 1, color: Color(0xffaaaaaa)),
              );
            },
          )),
    ));
  }

  ///构建竖向 Item 组件
  Widget _buildItem(BuildContext context, int index) {
    print("follow index:$index");
    Item item = items[index];
    return Container(
        decoration: BoxDecoration(color: Color(0xccffffff)),
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(item.data.header.icon,
                        width: 40, height: 40)),
                Padding(padding: EdgeInsets.only(left: 15)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.data.header.title,
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text(item.data.header.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff555555)))
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 15)),
                GestureDetector(
                  onTap: () {
                    JudyToast.showToast("关注");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1)),
                    padding:
                        EdgeInsets.only(left: 7, top: 3, right: 7, bottom: 3),
                    child: Text("+ 关注",
                        style: TextStyle(fontSize: 12, color: Colors.black)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 270,
              child: _buildHorizontalListView(item),
            )
          ],
        ));
  }

  ///竖向 Item 中横向图片列表及文本 ListView
  Widget _buildHorizontalListView(Item item) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: item.data.itemList.length,
      itemBuilder: (BuildContext context, int index) {
        //横向列表每个Item
        Item subItem = item.data.itemList[index];
        Data data = subItem.data;

        // 格式化时间
        String timeFormat = StringUtil.durationFormat(data.duration);

        //标签
        if (data.tags != null && data.tags.length > 0) {
          timeFormat = "#${data.tags[0].name} / $timeFormat";
        } else {
          timeFormat = "#$timeFormat";
        }

        return GestureDetector(
            onTap: () {
              VideoDetailPage.pushPage(context, subItem);
            },
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //横向 Item 图片
                  FadeInImage.assetNetwork(
                    width: 300,
                    height: 200,
                    placeholder: "images/placeholder_banner.png",
                    image: subItem.data.cover.feed,
                    fit: BoxFit.fill,
                  ),
                  //横向 Item title 文本
                  Container(
                      padding: EdgeInsets.only(left: 5, top: 10),
                      child: Text(data.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 14))),
                  //横向 Item 标签文本
                  Container(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Text(timeFormat,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xff9a9a9a), fontSize: 12)))
                ],
              ),
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 5);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  ///查询关注第一页数据
  void queryFollowList() async {
    discoveryModel.getFollowInfo().then((result) {
      setState(() {
        _isLoading = false;
        nextPageUrl = result.nextPageUrl;
        items.addAll(result.itemList);
      });
    }).catchError((e) {
      _isLoading = false;
      MLog.log(e);
      JudyToast.showToast("加载关注数据出错！");
    });
  }

  ///加载更多
  void _loadMore() async {
    if (StringUtil.isEmpty(nextPageUrl) || loadMoreFinished) {
      return;
    }
    discoveryModel.getFollowIssueData(nextPageUrl).then((result) {
      setState(() {
        nextPageUrl = result.nextPageUrl;
        loadMoreFinished = result.itemList.isEmpty;
        items.addAll(result.itemList);
      });
    }).catchError((e) {
      MLog.log(e);
    });
  }
}
