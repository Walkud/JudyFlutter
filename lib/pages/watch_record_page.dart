import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ty/db/watch_record_db.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/pages/video_detail_page.dart';
import 'package:ty/utils/string_util.dart';

///观看记录
class WatchRecordPage extends StatefulWidget {
  final List<Item> videoItems;

  WatchRecordPage(this.videoItems);

  @override
  State<StatefulWidget> createState() => WatchRecordState();

  static pushPage(BuildContext context) {
    WatchRecordDb.queryWatchRecordList().then((result) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return WatchRecordPage(result);
      }));
    });
  }
}

class WatchRecordState extends State<WatchRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          title: Text("观看记录",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Container(
          child: ListView.separated(
              itemCount: widget.videoItems.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(context, index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(
                    height: 0.5,
                    color: Color(0xffaaaaaa),
                  ),
                );
              }),
        ));
  }

  Widget _buildItem(BuildContext context, int index) {
    Item item = widget.videoItems[index];
    String tag = "#${item.data.category} / ${StringUtil.durationFormat(item.data.duration)}";

    return GestureDetector(
        onTap: () {
          VideoDetailPage.pushPage(context, item);
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: FadeInImage.assetNetwork(
                    height: 80,
                    width: 135,
                    placeholder: "images/placeholder_banner.png",
                    image: item.data.cover.detail,
                    fit: BoxFit.fill),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.data?.title,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    SizedBox(height: 5),
                    Text(tag,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffaaaaaa)))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
