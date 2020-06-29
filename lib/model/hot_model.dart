import 'package:ty/api/api_service.dart';

import 'bean/home_bean.dart';
import 'bean/tab_info_bean.dart';

class HotModel {
  /// 获取全部排行榜的Info（包括，title 和 Url）
  Future<TabInfoBean> getRankList() async {
    return ApiService.getInstance().getRankList();
  }

  ///获取热门-排行列表Issue数据
  Future<Issue> getHotRankData(String apiUrl) async{
    return ApiService.getInstance().getIssueData(apiUrl);
  }
}
