import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:ty/model/bean/author_info_bean.dart';
import 'package:ty/model/bean/category_bean.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'package:ty/model/bean/tab_info_bean.dart';
import 'package:ty/utils/m_log.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://baobab.kaiyanapp.com/api/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService _instance;

  static ApiService getInstance() {
    if (_instance == null) {
      final dio = Dio(); // Provide a dio instance
      dio.options.headers["token"] = "";
      dio.options.headers["User-Agent"] =
          "Mozilla/5.0 (Linux; Android 8.0.0; MI 5 Build/OPR1.170623.032; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/66.0.3359.126";
      Map<String, dynamic> queryParams =
          dio.options.queryParameters ?? HashMap();
      queryParams["udid"] = "d2807c895f0348a180148c9dfa6f2feeac0781b5";
      queryParams["deviceModel"] = "MI 5";
      dio.options.queryParameters = queryParams;
      dio.options.connectTimeout = 30000;
      dio.options.sendTimeout = 30000;
      dio.options.receiveTimeout = 30000;
      dio.interceptors.add(InterceptorsWrapper(onResponse: (Response response) {
        MLog.log(
            "url:${response.request.uri.toString()}\nstatusCode:${response.statusCode}\ndata:${response.data}");
      }, onError: (DioError e) {
        MLog.log(
            "url:${e.request.uri.toString()}\nstatusCode:${e.response.statusCode}\ndata:${e.response.data}");
      }));
      _instance = ApiService(dio);
    }

    return _instance;
  }

  ///首页 Banner 数据
  @GET('v2/feed')
  Future<HomeBean> getFirstHomeData(@Query("num") int num);

  ///获取首页列表数据
  ///url 下一页地址
  @GET('{url}')
  Future<HomeBean> getMoreHomeData(@Path("url") String url);

  /// 根据item id获取相关视频
  /// @param id
  @GET("v4/video/related")
  Future<Issue> getRelatedData(@Query("id") int id);

  /// 获取分类
  @GET("v4/categories")
  Future<List<CategoryBean>> getCategory();

  /// 获取分类详情List
  /// @param id
  @GET("v4/categories/videoList")
  Future<Issue> getCategoryDetailList(@Query("id") int id);

  /// 获取更多的 Issue
  /// @param url
  @GET('{url}')
  Future<Issue> getIssueData(@Path("url") String url);

  /// 获取全部排行榜的Info（包括，title 和 Url）
  @GET("v4/rankList")
  Future<TabInfoBean> getRankList();

  /// 获取搜索信息
  /// @param words
  @GET("v1/search?&num=10&start=10")
  Future<Issue> getSearchData(@Query("query") String words);

  /// 热门搜索词
  @GET("v3/queries/hot")
  Future<List<String>> getHotWord();

  /// 关注
  @GET("v4/tabs/follow")
  Future<Issue> getFollowInfo();

  /// 作者信息
  /// @param id
  @GET("v4/pgcs/detail/tab?")
  Future<AuthorInfoBean> getAuthorInfo(@Query("id") int id);
}
