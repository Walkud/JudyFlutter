import 'package:json_annotation/json_annotation.dart';

part 'home_bean.g.dart';

///  首页 Bean（视频详情，相关等 Bean）
@JsonSerializable()
class HomeBean extends Object {
  @JsonKey(name: 'issueList')
  List<Issue> issueList;

  @JsonKey(name: 'nextPageUrl')
  String nextPageUrl;

  @JsonKey(name: 'nextPublishTime')
  int nextPublishTime;

  @JsonKey(name: 'newestIssueType')
  String newestIssueType;

  HomeBean(
    this.issueList,
    this.nextPageUrl,
    this.nextPublishTime,
    this.newestIssueType,
  );

  factory HomeBean.fromJson(Map<String, dynamic> srcJson) =>
      _$HomeBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeBeanToJson(this);
}

@JsonSerializable()
class Issue extends Object {
  @JsonKey(name: 'releaseTime')
  int releaseTime;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'date')
  int date;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'itemList')
  List<Item> itemList;

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'nextPageUrl')
  String nextPageUrl;

  Issue(
    this.releaseTime,
    this.type,
    this.date,
    this.publishTime,
    this.itemList,
    this.count,
  );

  factory Issue.fromJson(Map<String, dynamic> srcJson) =>
      _$IssueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IssueToJson(this);
}

@JsonSerializable()
class Item extends Object {
  static const int ITEM_TYPE_CONTENT = 0; //item
  //Home
  static const int ITEM_TYPE_TEXT_HEADER = 1; //textHeader
  static const int ITEM_TYPE_BANNER = 2;//Banner
  //详情
  static const int ITEM_TYPE_TEXT_CARD = 11;
  static const int ITEM_TYPE_VIDEO_SMALL_CARD = 12;


  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'data')
  Data data;
  @JsonKey(name: 'tag')
  String tag;

  Item(this.type, this.data, this.tag);

  int getItemType() {
    int itype = ITEM_TYPE_CONTENT;
    switch (type) {
      case "textHeader":
        itype = ITEM_TYPE_TEXT_HEADER;
        break;
      case "textCard":
        itype = ITEM_TYPE_TEXT_CARD;
        break;
      case "videoSmallCard":
        itype = ITEM_TYPE_VIDEO_SMALL_CARD;
        break;
      case "Banner":
        itype = ITEM_TYPE_BANNER;
        break;
    }

    return itype;
  }

  factory Item.fromJson(Map<String, dynamic> srcJson) =>
      _$ItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'dataType')
  String dataType;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'videoTitle')
  String videoTitle;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'slogan')
  String slogan;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'actionUrl')
  String actionUrl;

  @JsonKey(name: 'provider')
  Provider provider;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'parentReply')
  ParentReply parentReply;

  @JsonKey(name: 'author')
  Author author;

  @JsonKey(name: 'cover')
  Cover cover;

  @JsonKey(name: 'likeCount')
  int likeCount;

  @JsonKey(name: 'playUrl')
  String playUrl;

  @JsonKey(name: 'thumbPlayUrl')
  String thumbPlayUrl;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'createTime')
  int createTime;

  @JsonKey(name: 'webUrl')
  WebUrl webUrl;

  @JsonKey(name: 'library')
  String library;

  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'playInfo')
  List<PlayInfo> playInfo;

  @JsonKey(name: 'consumption')
  Consumption consumption;

  @JsonKey(name: 'tags')
  List<Tag> tags;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'idx')
  int idx;

  @JsonKey(name: 'date')
  int date;

  @JsonKey(name: 'descriptionEditor')
  String descriptionEditor;

//  @JsonKey(name: 'collected')
//  bool collected;
//
//  @JsonKey(name: 'played')
//  bool played;

  @JsonKey(name: 'header')
  Header header;

  @JsonKey(name: 'itemList')
  List<Item> itemList;

  Data(
      this.dataType,
      this.text,
      this.videoTitle,
      this.id,
      this.title,
      this.slogan,
      this.description,
      this.image,
      this.actionUrl,
      this.provider,
      this.category,
      this.parentReply,
      this.author,
      this.cover,
      this.likeCount,
      this.playUrl,
      this.thumbPlayUrl,
      this.duration,
      this.message,
      this.createTime,
      this.webUrl,
      this.library,
      this.user,
      this.playInfo,
      this.consumption,
      this.tags,
      this.type,
      this.remark,
      this.idx,
      this.date,
      this.descriptionEditor,
//      this.collected,
//      this.played,
      this.header,
      this.itemList);

  Data.itemList(List<Item> itemList){
    this.itemList = itemList;
  }

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Tag extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'actionUrl')
  String actionUrl;

  Tag(this.id, this.name, this.actionUrl);

  factory Tag.fromJson(Map<String, dynamic> srcJson) => _$TagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@JsonSerializable()
class Author extends Object {
  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'description')
  String description;

  Author(this.icon, this.name, this.description);

  factory Author.fromJson(Map<String, dynamic> srcJson) =>
      _$AuthorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class Provider extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'alias')
  String alias;

  @JsonKey(name: 'icon')
  String icon;

  Provider(this.name, this.alias, this.icon);

  factory Provider.fromJson(Map<String, dynamic> srcJson) =>
      _$ProviderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProviderToJson(this);
}

@JsonSerializable()
class Cover extends Object {
  @JsonKey(name: 'feed')
  String feed;

  @JsonKey(name: 'detail')
  String detail;

  @JsonKey(name: 'blurred')
  String blurred;

  @JsonKey(name: 'sharing')
  String sharing;

  @JsonKey(name: 'homepage')
  String homepage;

  Cover(this.feed, this.detail, this.blurred, this.sharing, this.homepage);

  factory Cover.fromJson(Map<String, dynamic> srcJson) =>
      _$CoverFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CoverToJson(this);
}

@JsonSerializable()
class WebUrl extends Object {
  @JsonKey(name: 'raw')
  String raw;

  @JsonKey(name: 'forWeibo')
  String forWeibo;

  WebUrl(this.raw, this.forWeibo);

  factory WebUrl.fromJson(Map<String, dynamic> srcJson) =>
      _$WebUrlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WebUrlToJson(this);
}

@JsonSerializable()
class PlayInfo extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'urlList')
  List<Url> urlList;

  PlayInfo(this.name, this.url, this.type, this.urlList);

  factory PlayInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$PlayInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlayInfoToJson(this);
}

@JsonSerializable()
class Consumption extends Object {
  @JsonKey(name: 'collectionCount')
  int collectionCount;

  @JsonKey(name: 'shareCount')
  int shareCount;

  @JsonKey(name: 'replyCount')
  int replyCount;

  Consumption(this.collectionCount, this.shareCount, this.replyCount);

  factory Consumption.fromJson(Map<String, dynamic> srcJson) =>
      _$ConsumptionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ConsumptionToJson(this);
}

@JsonSerializable()
class User extends Object {
  @JsonKey(name: 'uid')
  int uid;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'userType')
  String userType;

//  @JsonKey(name: 'ifPgc')
//  bool ifPgc;

  User(this.uid, this.nickname, this.avatar, this.userType);

  factory User.fromJson(Map<String, dynamic> srcJson) =>
      _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class ParentReply extends Object {
  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'message')
  String message;

  ParentReply(this.user, this.message);

  factory ParentReply.fromJson(Map<String, dynamic> srcJson) =>
      _$ParentReplyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ParentReplyToJson(this);
}

@JsonSerializable()
class Url extends Object {
  @JsonKey(name: 'size')
  int size;

  Url(this.size);

  factory Url.fromJson(Map<String, dynamic> srcJson) => _$UrlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UrlToJson(this);
}

@JsonSerializable()
class Header extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'iconType')
  String iconType;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'font')
  String font;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'label')
  String label;

  @JsonKey(name: 'actionUrl')
  String actionUrl;

  @JsonKey(name: 'subtitle')
  String subtitle;

  @JsonKey(name: 'labelList')
  List<Label> labelList;

  Header(
      this.id,
      this.icon,
      this.iconType,
      this.description,
      this.title,
      this.font,
      this.cover,
      this.label,
      this.actionUrl,
      this.subtitle,
      this.labelList);

  factory Header.fromJson(Map<String, dynamic> srcJson) =>
      _$HeaderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

@JsonSerializable()
class Label extends Object {
  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'card')
  String card;

  @JsonKey(name: 'detial')
  String detial;

  @JsonKey(name: 'actionUrl')
  String actionUrl;

  Label(this.text, this.card, this.detial, this.actionUrl);

  factory Label.fromJson(Map<String, dynamic> srcJson) =>
      _$LabelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LabelToJson(this);
}
