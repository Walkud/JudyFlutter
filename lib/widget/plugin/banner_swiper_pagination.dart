import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:ty/utils/m_log.dart';

class SquareSwiperPagination extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final String title;

  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the dot when activate
  final double activeSize;

  ///Size of the dot
  final double size;

  /// Space between dots
  final double space;

  final Key key;

  const SquareSwiperPagination(
      {this.title,
      this.activeColor,
      this.color,
      this.key,
      this.size: 10.0,
      this.activeSize: 10.0,
      this.space: 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    if (config.itemCount > 20) {
      MLog.log(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }
    Color activeColor = this.activeColor;
    Color color = this.color;

    if (activeColor == null || color == null) {
      ThemeData themeData = Theme.of(context);
      activeColor = this.activeColor ?? themeData.primaryColor;
      color = this.color ?? themeData.scaffoldBackgroundColor;
    }

    if (config.indicatorLayout != PageIndicatorLayout.NONE &&
        config.layout == SwiperLayout.DEFAULT) {
      return new PageIndicator(
        count: config.itemCount,
        controller: config.pageController,
        layout: config.indicatorLayout,
        size: size,
        activeColor: activeColor,
        color: color,
        space: space,
      );
    }

    List<Widget> list = [];

    list.add(Expanded(
        child: Text(
      title ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Color(0xccffffff), fontSize: 14),
    )));

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      list.add(Container(
        key: Key("pagination_$i"),
        margin: EdgeInsets.all(space),
        child: Container(
//          color: active ? activeColor : color,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 2),
            color: active ? activeColor : color,
          ),
          width: active ? activeSize : size,
          height: active ? activeSize : size,
        ),
      ));
    }

    return Container(
        height: 30,
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(color: Color(0x33000000)),
        child: new Row(
          key: key,
          mainAxisSize: MainAxisSize.min,
          children: list,
        ));
  }
}
