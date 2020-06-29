import 'package:ty/api/api_service.dart';

import 'bean/home_bean.dart';

///视频详情页面 Model
class VideoDetailModel {

  ///根据item id获取相关视频
  Future<Issue> getRelatedData(int id) async{
    return ApiService.getInstance().getRelatedData(id);
  }
}
