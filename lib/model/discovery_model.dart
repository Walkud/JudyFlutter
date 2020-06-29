import 'package:ty/api/api_service.dart';

import 'bean/category_bean.dart';
import 'bean/home_bean.dart';

class DiscoveryModel {
  ///获取关注信息
  Future<Issue> getFollowInfo() async {
    return ApiService.getInstance().getFollowInfo();
  }

  ///关注列表加载更多数据
  Future<Issue> getFollowIssueData(String url) async {
    return ApiService.getInstance().getIssueData(url);
  }

  /// 获取分类
  Future<List<CategoryBean>> getCategory() async{
    return ApiService.getInstance().getCategory();
  }

  /// 获取分类详情List
  Future<Issue> getCategoryDetailList(int id) async{
    return ApiService.getInstance().getCategoryDetailList(id);
  }

  ///获取详情列表更多数据
  Future<Issue>  getMoreCategoryData(String url) async{
    return ApiService.getInstance().getIssueData(url);
  }
}
