import 'dart:math';

import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ty/db/watch_record_db.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/model/video_detail_model.dart';
import 'package:ty/utils/app_context.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/string_util.dart';
import 'package:ty/utils/toast_util.dart';

class VideoDetailPage extends StatefulWidget {
  final Item videoItem;

  VideoDetailPage(this.videoItem);

  @override
  State<StatefulWidget> createState() => VideoDetailState(videoItem);

  static void pushPage(BuildContext context, Item videoItem) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => VideoDetailPage(videoItem)));
  }
}

class VideoDetailState extends State<VideoDetailPage> {
  final VideoDetailModel videoDetailModel = VideoDetailModel();
  final TextStyle textStyle12 =
      TextStyle(fontSize: 12, color: Color(0xffdddddd));
  final TextStyle textStyle14 =
      TextStyle(fontSize: 14, color: Color(0xffdddddd));
  final TextStyle textStyle16 = TextStyle(
      fontSize: 16, color: Color(0xffeeeeee), fontWeight: FontWeight.bold);

  Item videoItem;

  VideoDetailState(this.videoItem);

  List<Item> items = [];

  String playUrl = "";

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppContext.getSystemUiOverlayLightStyle(),
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            RefreshIndicator(
              displacement: 30,
              onRefresh: _handleRefresh,
              child: Column(children: <Widget>[
//                topStatusBar,
                //根据url判断是否使用占位组件
                StringUtil.isNotEmpty(playUrl)
                    ? AwsomeVideoPlayer(playUrl,

                        /// 视频播放配置
                        playOptions: VideoPlayOptions(
                            aspectRatio: 16 / 9,
                            loop: false,
                            autoplay: true,
                            allowScrubbing: true,
                            startPosition: Duration(seconds: 0)),

                        /// 自定义视频样式
                        videoStyle: VideoStyle(

                            /// 自定义视频暂停时视频中部的播放按钮
                            playIcon: Icon(
                              Icons.play_circle_outline,
                              size: 50,
                              color: Colors.white,
                            ),

                            /// 暂停时是否显示视频中部播放按钮
                            showPlayIcon: true,

                            /// 自定义底部控制栏
                            videoControlBarStyle: VideoControlBarStyle(
                              /// 自定义颜色
                              barBackgroundColor: Color(0x99000000),

                              /// 自定义进度条样式
                              progressStyle: VideoProgressStyle(
                                  // padding: EdgeInsets.all(0),
                                  playedColor: Color(0xff005fff),
                                  bufferedColor: Color(0xffe0e0e0),
                                  backgroundColor: Color(0xcc999999),
                                  dragBarColor: Colors.white,
                                  //进度条为`progress`时有效，如果时`basic-progress`则无效
                                  height: 4,
                                  progressRadius: 2,
                                  //进度条为`progress`时有效，如果时`basic-progress`则无效
                                  dragHeight:
                                      5 //进度条为`progress`时有效，如果时`basic-progress`则无效
                                  ),

                              /// 更改进度栏的播放按钮
                              playIcon: Icon(Icons.play_arrow,
                                  color: Colors.white, size: 16),

                              /// 更改进度栏的暂停按钮
                              pauseIcon: Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 16,
                              ),

                              /// 更改进度栏的全屏按钮
                              fullscreenIcon: Icon(
                                Icons.fullscreen,
                                size: 16,
                                color: Colors.white,
                              ),

                              /// 更改进度栏的退出全屏按钮
                              fullscreenExitIcon: Icon(
                                Icons.fullscreen_exit,
                                size: 16,
                                color: Colors.white,
                              ),

                              /// 决定控制栏的元素以及排序，示例见上方图3
                              itemList: [
                                "play",
                                "position-time", //当前播放时间
                                "progress", //线形进度条
                                "duration-time", //视频总时长
                                "fullscreen"
                              ],
                            ),
                            videoTopBarStyle: VideoTopBarStyle(
                              height: 50,
                              padding:EdgeInsets.only(top: 18,left: 10),
                            )
                        ),

                        /// 顶部控制栏点击返回按钮
                        onpop: (value) {
                        Navigator.pop(context);
                      })
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                      ),
                //视频下方列表组件
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            //列表背景图片，从服务器上拉取
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(_getBackgroudImageUrl()))),
                        child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildItem(context, items[index]);
                            })))
              ]),
            ),
          ],
        )));
  }

  /// 刷新数据
  Future<Null> _handleRefresh() async {
    WatchRecordDb.saveWatchRecord(videoItem);
    List<PlayInfo> playInfos = videoItem.data.playInfo;
    var connectivityResult = await (Connectivity().checkConnectivity());

    String playUrl;
    //判断是否使用高清视频播放
    if (playInfos != null && playInfos.isNotEmpty) {
      bool wifiType = connectivityResult == ConnectivityResult.wifi;
      String typeText = "normal";
      if (wifiType) {
        typeText = "high";
      }
      for (var value in playInfos) {
        if (value.type == typeText) {
          playUrl = value.url;

          if (connectivityResult != ConnectivityResult.none && !wifiType) {
            JudyToast.showToast(
                "本次消耗${StringUtil.dataFormat(value.urlList[0].size)}流量");
          }
        }
      }
    } else {
      playUrl = videoItem.data.playUrl;
    }

    setState(() {
      this.playUrl = playUrl;
    });

    videoDetailModel.getRelatedData(videoItem.data?.id).then((result) {
      result.itemList.insert(0, videoItem);
      setState(() {
        items = result.itemList;
      });
    });
  }

  ///构建列表 Item
  Widget _buildItem(BuildContext context, Item item) {
    switch (item.getItemType()) {
      case Item.ITEM_TYPE_CONTENT:
        return _buildContent(context, item);
      case Item.ITEM_TYPE_TEXT_CARD:
        return _buildTextCard(context, item);
      case Item.ITEM_TYPE_VIDEO_SMALL_CARD:
        return _buildVideoSmallCard(context, item);
    }

    return Container();
  }

  /// 构建列表简介 Item 及功能 Item
  Widget _buildContent(BuildContext context, Item item) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Color(0x44000000)),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //视频简介
              Padding(padding: EdgeInsets.only(top: 5)),
              Text(item.data.title, style: textStyle16),
              Padding(padding: EdgeInsets.only(top: 5)),
              Text(
                  "#${item.data?.category} / ${StringUtil.durationFormat(item.data?.duration)}",
                  style: textStyle14),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(item.data.description, style: textStyle12),
              Padding(padding: EdgeInsets.only(top: 10)),
              //功能 Item
              Row(
                children: <Widget>[
                  //喜欢
                  Flexible(
                      child: getAtionItem(
                          item.data?.consumption?.collectionCount.toString(),
                          "images/ic_action_favorites.png",
                          1)),
                  //分享
                  Flexible(
                      child: getAtionItem(
                          item.data?.consumption?.shareCount.toString(),
                          "images/ic_action_share.png",
                          2)),
                  //评论
                  Flexible(
                      child: getAtionItem(
                          item.data?.consumption?.replyCount.toString(),
                          "images/ic_action_reply.png",
                          3)),
                  //缓存
                  Flexible(
                      child:
                          getAtionItem("缓存", "images/ic_action_offline.png", 4))
                ],
              ),
            ],
          ),
        ),
        _buildAuthor(context, item)
      ],
    );
  }

  /// 构建分类 Card
  Widget _buildTextCard(BuildContext context, Item item) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 20, right: 15),
      child: Row(
        children: <Widget>[
          Text(item.data?.text,
              style: TextStyle(
                  fontFamily: 'FZLanTingHeiS-L',
                  fontSize: 12,
                  color: Colors.white)),
//          Padding(padding: EdgeInsets.only(left: 10)),
          Image.asset("images/ic_action_more_arrow.png", width: 30, height: 30)
        ],
      ),
    );
  }

  /// 构建视频分类列表
  Widget _buildVideoSmallCard(BuildContext context, Item item) {
    return GestureDetector(
        onTap: () {
          item.type = "video";
          videoItem = item;
          items.remove(item);
          items[0] = item;

          _handleRefresh();
        },
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15)),
            Row(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: //视频图片
                        FadeInImage.assetNetwork(
                      width: 135,
                      height: 80,
                      placeholder: "images/placeholder_banner.png",
                      image: item.data.cover.detail,
                      fit: BoxFit.fill,
                    )),
                Padding(padding: EdgeInsets.only(left: 15)),
                //视频说明及类型
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.data?.title,
                            maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Text(
                            "#${item.data.category} / ${StringUtil.durationFormat(item.data.duration)}",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffaaaaaa))),
                      ]),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Divider(height: 1, color: Color(0xffaaaaaa))
          ]),
        ));
  }

  /// 构建视频作者信息
  Widget _buildAuthor(BuildContext context, Item item) {
    if (item.data?.author != null) {
      return Container(
          child: Column(children: <Widget>[
        Divider(height: 1, color: Color(0xffaaaaaa)),
        Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Image.network(item.data.cover.detail, width: 40, height: 40),
                Padding(padding: EdgeInsets.only(left: 15)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.data.author.name,
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Padding(padding: EdgeInsets.only(top: 2)),
                      Text(item.data.author.description,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffaaaaaa)))
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
                        border: Border.all(color: Colors.white, width: 1)),
                    padding:
                        EdgeInsets.only(left: 7, top: 3, right: 7, bottom: 3),
                    child: Text("+ 关注",
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                )
              ],
            )),
        Divider(height: 1, color: Color(0xffaaaaaa))
      ]));
    }

    return Container();
  }

  /// 封装功能 Item
  Widget getAtionItem(String text, String imageRes, int type) {
    return GestureDetector(
      onTap: () {
        _ationItemClick(type);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageRes, width: 20, height: 20),
          Padding(padding: EdgeInsets.only(left: 10)),
          Text(text, style: textStyle14)
        ],
      ),
    );
  }

  ///功能 Item 点击事件
  void _ationItemClick(int type) {
    switch (type) {
      case 1:
        JudyToast.showToast("喜欢");
        break;
      case 2:
        JudyToast.showToast("分享");
        break;
      case 3:
        JudyToast.showToast("评论");
        break;
      case 4:
        JudyToast.showToast("缓存");
        break;
    }
  }

  /// 获取列表背景图片Url
  String _getBackgroudImageUrl() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    String backgroudImageurl =
        "${widget.videoItem.data.cover.blurred}/thumbnail/${height - 250}x$width";
    MLog.log("backgroudImageurl:$backgroudImageurl");
    return backgroudImageurl;
  }
}
