import 'package:flutter/material.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/pages/home_page.dart';
import 'package:ty/pages/search_page.dart';

class HomeToolBar extends StatefulWidget {
  ScrollController scrollController;

  HomeToolBar(this.scrollController);

  HomeToolBarState _state = HomeToolBarState();

  @override
  State<StatefulWidget> createState() => _state;

  void clearTitlePosision() {
    _state.clearTitlePosision();
  }

  void calTitlePosistion(List<Item> items) {
    _state.calTitlePosistion(items);
  }
}

class HomeToolBarState extends State<HomeToolBar> {
  double offsetDy = 0; //起始的偏移位置要算上Banner高度
  List<double> _titleItemOffsetDys = [];
  List<String> _offsetItemTitles = [];
  int _titleTargetIndex = 0;
  String pageTitle = "";
  bool isShowToolBar = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      double offset = widget.scrollController.offset;
      bool isShowBar = offset > APPBAR_SCROLL_OFFSET;
      if (isShowBar != isShowToolBar) {
        setState(() {
          isShowToolBar = isShowBar;
        });
      }
      _calCurrentTitle(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    String imageRes = 'images/ic_action_search_white.png';
    if (isShowToolBar) {
      imageRes = 'images/ic_action_search_black.png';
    }

    return Container(
      height: 100,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Offstage(
            offstage: !isShowToolBar,
            child: Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(204, 255, 255, 255)),
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.bottomCenter,
                child: Text(
                  pageTitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(isShowToolBar ? 255 : 0, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                )),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(bottom: 12, right: 10),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SearchPage();
                  }));
                },
                child: Image.asset(
                  imageRes,
                  width: 35,
                  height: 35,
                )),
          )
        ],
      ),
    );
  }

  /// Begin 由于 Flutter ListView 没有提供获取可见的第一个Item方法，所以这里自己写了一个获取列表中第一个可见的 Title 名称

  ///计算出当前显示的 Title 名称
  void _calCurrentTitle(double offset) {
    //计算出当前可见的第一个 Title 并获取内容,改逻辑已优化，只遍历当前显示Title的前后，最大遍历数为3
    int dyLen = _titleTargetIndex + 1;
    int min = _titleTargetIndex > 0 ? _titleTargetIndex - 1 : 0;

    for (int i = dyLen; i >= min; i--) {
      if (i == _titleItemOffsetDys.length) {
        continue;
      }

      double dy1 = _titleItemOffsetDys[i];
      if (dy1 < offset) {
        setState(() {
          _titleTargetIndex = i;
          pageTitle = _offsetItemTitles[i];
        });
        break;
      }
    }
  }

  /// 清除 Title 相关数据缓存
  void clearTitlePosision() {
    offsetDy = 0;
    _titleTargetIndex = 0;
    _titleItemOffsetDys.clear();
    _offsetItemTitles.clear();
  }

  ///计算 Title Y 轴位置并缓存，用于滑动时获取可见的第一个 Title
  void calTitlePosistion(List<Item> items) {
    for (int i = 0; i < items.length; i++) {
      Item item = items[i];
      //计算 Title 偏移量
      if (item.getItemType() == Item.ITEM_TYPE_TEXT_HEADER) {
        _titleItemOffsetDys.add(offsetDy);
        _offsetItemTitles.add(item.data.text);
        offsetDy += 50;
      } else if (item.getItemType() == Item.ITEM_TYPE_BANNER) {
        offsetDy = 230;
      } else {
        offsetDy += 310.5;
      }
    }
  }

  /// End
}
