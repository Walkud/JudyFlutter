import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ty/pages/watch_record_page.dart';
import 'package:ty/utils/toast_util.dart';

import 'about_page.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MinePageState();
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  Color _9a9a9a = Color(0xff9a9a9a);
  Color _textGray = Color(0xff555555);
  List<String> actionList = ["我的消息", "我的关注", "我的缓存", "观看记录", "意见反馈"];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          width: 50,
          height: 50,
          padding: EdgeInsets.only(right: 15),
          child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutPage();
                }));
              },
              child: Image.asset("images/ic_about.png",
                  width: 24, height: 24, alignment: Alignment.center)),
        ),
        Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _9a9a9a, width: 2)),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset("images/img_avatar.png"),
                ))),
        Text("Walkud",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 15),
          child: GestureDetector(
              onTap: () {
                JudyToast.showToast("查看个人主页");
              },
              child: Text("查看个人主页 >",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: _9a9a9a))),
        ),
        Divider(
          color: _9a9a9a,
        ),
        Row(
          children: <Widget>[
            _buildIconTextItem("images/ic_action_collection.png", "收藏", 1),
            Container(
              width: 0.5,
              height: 22,
              color: _9a9a9a,
            ),
            _buildIconTextItem("images/ic_action_comment.png", "评论", 2)
          ],
        ),
        Divider(
          color: _9a9a9a,
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: actionList.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildAtionItem(context, index);
            })
      ],
    );
  }

  Widget _buildIconTextItem(String iconRes, String text, int type) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        if (type == 1) {
          JudyToast.showToast("收藏");
        } else if (type == 2) {
          JudyToast.showToast("评论");
        }
      },
      child: Container(
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(iconRes, width: 16, height: 16),
            Padding(padding: EdgeInsets.only(left: 7)),
            Text(
              text,
              style: TextStyle(fontSize: 14, color: _textGray),
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildAtionItem(BuildContext context, int index) {
    return Container(
      height: 50,
      child: GestureDetector(
        onTap: () {
          _ationClick(index);
        },
        child: Text(actionList[index],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: _textGray)),
      ),
    );
  }

  void _ationClick(int index) {
    switch (index) {
      case 0: //我的消息
        JudyToast.showToast(actionList[index]);
        break;
      case 1: //我的关注
        JudyToast.showToast(actionList[index]);
        break;
      case 2: //我的缓存
        JudyToast.showToast(actionList[index]);
        break;
      case 3: //观看记录
        WatchRecordPage.pushPage(context);
        break;
      case 4: //意见反馈
        JudyToast.showToast(actionList[index]);
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
