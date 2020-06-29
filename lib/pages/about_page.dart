import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:ty/utils/native_schema_util.dart';
import 'package:ty/utils/toast_util.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  String _version = "";
  Color grayColor = Color(0xff9a9a9a);
  List<String> _ationItems = ["Github", "意见反馈"];

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        _version = 'v${packageInfo.version}';
      });
    });
  }

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
        title: Text("关于",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xffeeeeee),
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            Center(
                child: Image.asset("images/web_hi_res_512.png",
                    width: 100, height: 100)),
            Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text("Judy Flutter",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Lobster',
                        fontWeight: FontWeight.bold))),
            Text(_version, style: TextStyle(color: grayColor, fontSize: 14)),
            Padding(padding: EdgeInsets.only(top: 20)),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _ationItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildActionItem(context, index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 1, color: grayColor);
                }),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("内容部分数据归原公司《开眼Eyepetizer》版权所有",
                      style: TextStyle(color: grayColor, fontSize: 12)),
                  Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 25),
                      child: Text("本APP只供学习交流和研究之用，\n请勿用作商业用途！",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: grayColor, fontSize: 12))),
                  Text("copyright ©2020 Judy.",
                      style: TextStyle(color: grayColor, fontSize: 10))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      height: 40,
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          _ationClick(context, index);
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(_ationItems[index],
                  style: TextStyle(color: Colors.black)),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: grayColor,
              size: 12,
            )
          ],
        ),
      ),
    );
  }

  void _ationClick(BuildContext context, int index) {
    switch (index) {
      case 0:
        NativeSchemaUtil.openURL("https://github.com/Walkud/JudyKotlinMvp");
        break;
      case 1:
        JudyToast.showToast(_ationItems[index]);
        break;
    }
  }
}
