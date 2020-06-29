
import 'package:ty/api/api_service.dart';

import 'bean/home_bean.dart';

class SearchModel{

  /// 热门搜索词
  Future<List<String>> getHotWord(){
    return ApiService.getInstance().getHotWord();
  }

  ///获取搜索信息
  Future<Issue> getSearchData( String words){
    return ApiService.getInstance().getSearchData(words);
  }

  ///获取更多的 Issue
  Future<Issue> getSearchIssueData(String url){
    return ApiService.getInstance().getIssueData(url);
  }

}