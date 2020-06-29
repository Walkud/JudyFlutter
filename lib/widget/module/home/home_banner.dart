import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/pages/home_page.dart';
import 'package:ty/pages/video_detail_page.dart';
import 'package:ty/widget/plugin/banner_swiper_pagination.dart';

class HomeBanner extends StatefulWidget {
  List<Item> itemList;

  HomeBanner(this.itemList);

  @override
  State<StatefulWidget> createState() => HomeBannerState();
}

class HomeBannerState extends State<HomeBanner>
    with AutomaticKeepAliveClientMixin {
  String bannerTitle = "";

  @override
  Widget build(BuildContext context) {
    List<Item> itemList = widget.itemList;
    return Container(
      height: APPBAR_SCROLL_OFFSET,
      child: Swiper(
        itemCount: itemList.length,
        autoplay: true,
        onIndexChanged: (index) {
          setState(() {
            bannerTitle = itemList[index].data.title;
          });
        },
        pagination: SwiperPagination(
          builder: SquareSwiperPagination(
            title: bannerTitle,
            size: 6,
            activeSize: 6,
            color: Colors.white.withAlpha(80),
            activeColor: Colors.white,
          ),
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        ),
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
              onTap: () {
                VideoDetailPage.pushPage(context, itemList[index]);
              },
              child:
              //Banner Item 图片
              FadeInImage.assetNetwork(
                placeholder: "images/placeholder_banner.png",
                image: itemList[index].data.cover.feed,
                fit: BoxFit.fill,
              ));
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}