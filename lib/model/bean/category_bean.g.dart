// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryBean _$CategoryBeanFromJson(Map<String, dynamic> json) {
  return CategoryBean(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['bgPicture'] as String,
    json['bgColor'] as String,
    json['headerImage'] as String,
  );
}

Map<String, dynamic> _$CategoryBeanToJson(CategoryBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'bgPicture': instance.bgPicture,
      'bgColor': instance.bgColor,
      'headerImage': instance.headerImage,
    };
