import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ty/pages/discovery_page.dart';
import 'package:ty/pages/home_page.dart';
import 'package:ty/pages/hot_page.dart';
import 'package:ty/pages/mine_page.dart';

///主页底部 Tab 导航按钮
class MainTabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainTabNavigatorState();
}

class MainTabNavigatorState extends State<MainTabNavigator> {
  final _defaultColor = Color(0xff9a9a9a);
  final _activeColor = Colors.black;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        //页面
        body: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),//禁止滚动
          children: <Widget>[
            HomePage(),
            DiscoveryPage(),
            HotPage(),
            MinePage()
          ],
        ),
        //底部 TabBar ，高斯模糊、分隔线、tab切换控制(图标及文字颜色)
        bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
                //高斯模糊
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Stack(
                  children: <Widget>[
                    //底部TabBar横向列表
                    BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: Color(0xccffffff),
                      currentIndex: _currentIndex,
                      onTap: (index) {
                        //底部按钮点击事件
                        _controller.jumpToPage(index);
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      type: BottomNavigationBarType.fixed,
                      selectedFontSize: 12,
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'images/ic_home_normal.png',
                            width: 22,
                            height: 22,
                          ),
                          activeIcon: Image.asset(
                            'images/ic_home_selected.png',
                            width: 22,
                            height: 22,
                          ),
                          title: Text(
                            '每日精选',
                            style: TextStyle(
                              color: _currentIndex != 0
                                  ? _defaultColor
                                  : _activeColor,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'images/ic_discovery_normal.png',
                            width: 22,
                            height: 22,
                          ),
                          activeIcon: Image.asset(
                            'images/ic_discovery_selected.png',
                            width: 22,
                            height: 22,
                          ),
                          title: Text(
                            '发现',
                            style: TextStyle(
                              color: _currentIndex != 1
                                  ? _defaultColor
                                  : _activeColor,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'images/ic_hot_normal.png',
                            width: 22,
                            height: 22,
                          ),
                          activeIcon: Image.asset(
                            'images/ic_hot_selected.png',
                            width: 22,
                            height: 22,
                          ),
                          title: Text(
                            '热门',
                            style: TextStyle(
                              color: _currentIndex != 2
                                  ? _defaultColor
                                  : _activeColor,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            'images/ic_mine_normal.png',
                            width: 22,
                            height: 22,
                          ),
                          activeIcon: Image.asset(
                            'images/ic_mine_selected.png',
                            width: 22,
                            height: 22,
                          ),
                          title: Text(
                            '我的',
                            style: TextStyle(
                              color: _currentIndex != 3
                                  ? _defaultColor
                                  : _activeColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    //分割线
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Divider(
                          thickness: 0.5,
                          height: 0.5,
                          indent: 0,
                          endIndent: 0,
                          color: Color(0xff9a9a9a)),
                    )
                  ],
                ))));
  }
}
