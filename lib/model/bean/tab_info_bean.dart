
import 'package:json_annotation/json_annotation.dart';

part 'tab_info_bean.g.dart';

@JsonSerializable()
class TabInfoBean extends Object {

  @JsonKey(name: 'tabInfo')
  TabInfo tabInfo;

  TabInfoBean(this.tabInfo);

  factory TabInfoBean.fromJson(Map<String, dynamic> srcJson) =>
      _$TabInfoBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabInfoBeanToJson(this);
}

@JsonSerializable()
class TabInfo extends Object{
  @JsonKey(name: 'tabList')
  List<Tab> tabList;

  TabInfo(this.tabList);

  factory TabInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$TabInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabInfoToJson(this);

}

@JsonSerializable()
class Tab extends Object{
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'apiUrl')
  String apiUrl;

  Tab(this.id, this.name, this.apiUrl);

  factory Tab.fromJson(Map<String, dynamic> srcJson) =>
      _$TabFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TabToJson(this);
}