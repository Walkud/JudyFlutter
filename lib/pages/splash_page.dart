import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/widget/navigator/main_tab_navigator.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

/// 闪屏页
class SplashPageState extends State<SplashPage> {
  String _version = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            //顶部图标与名称定位组件
            Positioned(
                top: 120,
                left: 10,
                right: 10,
                child: Column(
                  children: <Widget>[
                    //图标
                    Image.asset(
                      'images/web_hi_res_512.png',
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    //名称
                    Text(
                      'Judy Flutter',
                      style: TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            //底部描述和版本定位组件
            Positioned(
              bottom: 90,
              left: 10,
              right: 10,
              child: Column(
                children: <Widget>[
                  //描述
                  Text(
                    '每日精选视频，让你大开眼界',
                    style:
                        TextStyle(fontFamily: 'FZLanTingHeiS-L', fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
//                  //版本
                  Text(
                    _version,
                    style: TextStyle(fontSize: 12, color: Color(0XFF9A9A9A)),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        _version = 'v${packageInfo.version}';
      });
    });

    _requestPermission();
  }

  void _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
      Permission.storage,
    ].request();

    statuses.forEach((key, value) {
      MLog.log("permission:$key,status:$value");
    });

    _forwardMainTabNavigator();
  }

  void _forwardMainTabNavigator() {
    //延迟两秒跳转至主页
    Timer(Duration(seconds: 2), () {
      setState(() {
        //跳转并退出当前页面
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainTabNavigator()),
            (route) => false);
      });
    });
  }
}
