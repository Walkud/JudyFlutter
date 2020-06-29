import 'package:json_annotation/json_annotation.dart';

part 'category_bean.g.dart';

@JsonSerializable()
class CategoryBean extends Object {

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'bgPicture')
  String bgPicture;
  @JsonKey(name: 'bgColor')
  String bgColor;
  @JsonKey(name: 'headerImage')
  String headerImage;

  CategoryBean(this.id, this.name, this.description, this.bgPicture,
      this.bgColor, this.headerImage);


  factory CategoryBean.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoryBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryBeanToJson(this);
}
