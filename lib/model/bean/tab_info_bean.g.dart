// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabInfoBean _$TabInfoBeanFromJson(Map<String, dynamic> json) {
  return TabInfoBean(
    json['tabInfo'] == null
        ? null
        : TabInfo.fromJson(json['tabInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TabInfoBeanToJson(TabInfoBean instance) =>
    <String, dynamic>{
      'tabInfo': instance.tabInfo,
    };

TabInfo _$TabInfoFromJson(Map<String, dynamic> json) {
  return TabInfo(
    (json['tabList'] as List)
        ?.map((e) => e == null ? null : Tab.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TabInfoToJson(TabInfo instance) => <String, dynamic>{
      'tabList': instance.tabList,
    };

Tab _$TabFromJson(Map<String, dynamic> json) {
  return Tab(
    json['id'] as int,
    json['name'] as String,
    json['apiUrl'] as String,
  );
}

Map<String, dynamic> _$TabToJson(Tab instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'apiUrl': instance.apiUrl,
    };
