import 'package:ty/api/api_service.dart';
import 'package:ty/utils/m_log.dart';
import 'package:ty/utils/string_util.dart';

import 'bean/home_bean.dart';

class HomeModel {
  /// 获取首页数据
  /// 这个方法主要做了三件事，以后接口合并可只修改这一处
  /// 1、先请求Banner数据
  /// 2、过滤掉 Banner2(包含广告,等不需要的 Type)
  /// 3、根据 nextPageUrl 请求下一页数据
  Future<HomeBean> getFirstHomeData() async {
    return ApiService.getInstance()
        .getFirstHomeData(1)
        .then((HomeBean bannerHomeBean) {
      //过滤广告
      _filterAd(bannerHomeBean);

      //获取列表数据
      return getMoreHomeData(bannerHomeBean.nextPageUrl)
          .then((HomeBean homeBean) {
        //设置Banner数据
        Data data = Data.itemList(bannerHomeBean.issueList[0].itemList);
        Item item = new Item("Banner", data, "");
        homeBean.issueList[0].itemList.insert(0, item);
        return homeBean;
      });
    });
  }

  ///加载首页更多数据
  Future<HomeBean> getMoreHomeData(String url) async {
    HomeBean homeBean = await ApiService.getInstance().getMoreHomeData(url);
    //这里一次添加查询2页数据
    if (!StringUtil.isEmpty(homeBean.nextPageUrl)) {
      HomeBean nextHomeBean =
          await ApiService.getInstance().getMoreHomeData(homeBean.nextPageUrl);
      homeBean.issueList[0].itemList.addAll(nextHomeBean.issueList[0].itemList);
      homeBean.nextPageUrl = nextHomeBean.nextPageUrl;
    }

    ////过滤广告
    _filterAd(homeBean);
//      MLog.log("getMoreHomeData:${homeBean == null}");
    return homeBean;
  }

  ///过滤掉 Banner2(包含广告,等不需要的 Type)
  void _filterAd(HomeBean homeBean) {
    //过滤掉 Banner2(包含广告,等不需要的 Type)
    List<Item> itemList = homeBean.issueList[0].itemList;
    //需要过滤的类型
    List<String> filterTypes = ["campaign", "banner2", "horizontalScrollCard"];

    itemList.removeWhere((item) {
      //移除过滤类型的item
      return filterTypes.contains(item.type);
    });
  }
}
