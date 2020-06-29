// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBean _$HomeBeanFromJson(Map<String, dynamic> json) {
  return HomeBean(
    (json['issueList'] as List)
        ?.map(
            (e) => e == null ? null : Issue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['nextPageUrl'] as String,
    json['nextPublishTime'] as int,
    json['newestIssueType'] as String,
  );
}

Map<String, dynamic> _$HomeBeanToJson(HomeBean instance) => <String, dynamic>{
      'issueList': instance.issueList,
      'nextPageUrl': instance.nextPageUrl,
      'nextPublishTime': instance.nextPublishTime,
      'newestIssueType': instance.newestIssueType,
    };

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return Issue(
    json['releaseTime'] as int,
    json['type'] as String,
    json['date'] as int,
    json['publishTime'] as int,
    (json['itemList'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  )
    ..total = json['total'] as int
    ..nextPageUrl = json['nextPageUrl'] as String;
}

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'releaseTime': instance.releaseTime,
      'type': instance.type,
      'date': instance.date,
      'total': instance.total,
      'publishTime': instance.publishTime,
      'itemList': instance.itemList,
      'count': instance.count,
      'nextPageUrl': instance.nextPageUrl,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['type'] as String,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
    json['tag'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'tag': instance.tag,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['dataType'] as String,
    json['text'] as String,
    json['videoTitle'] as String,
    json['id'] as int,
    json['title'] as String,
    json['slogan'] as String,
    json['description'] as String,
    json['image'] as String,
    json['actionUrl'] as String,
    json['provider'] == null
        ? null
        : Provider.fromJson(json['provider'] as Map<String, dynamic>),
    json['category'] as String,
    json['parentReply'] == null
        ? null
        : ParentReply.fromJson(json['parentReply'] as Map<String, dynamic>),
    json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    json['cover'] == null
        ? null
        : Cover.fromJson(json['cover'] as Map<String, dynamic>),
    json['likeCount'] as int,
    json['playUrl'] as String,
    json['thumbPlayUrl'] as String,
    json['duration'] as int,
    json['message'] as String,
    json['createTime'] as int,
    json['webUrl'] == null
        ? null
        : WebUrl.fromJson(json['webUrl'] as Map<String, dynamic>),
    json['library'] as String,
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    (json['playInfo'] as List)
        ?.map((e) =>
            e == null ? null : PlayInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['consumption'] == null
        ? null
        : Consumption.fromJson(json['consumption'] as Map<String, dynamic>),
    (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['type'] as String,
    json['remark'] as String,
    json['idx'] as int,
    json['date'] as int,
    json['descriptionEditor'] as String,
    json['header'] == null
        ? null
        : Header.fromJson(json['header'] as Map<String, dynamic>),
    (json['itemList'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'dataType': instance.dataType,
      'text': instance.text,
      'videoTitle': instance.videoTitle,
      'id': instance.id,
      'title': instance.title,
      'slogan': instance.slogan,
      'description': instance.description,
      'image': instance.image,
      'actionUrl': instance.actionUrl,
      'provider': instance.provider,
      'category': instance.category,
      'parentReply': instance.parentReply,
      'author': instance.author,
      'cover': instance.cover,
      'likeCount': instance.likeCount,
      'playUrl': instance.playUrl,
      'thumbPlayUrl': instance.thumbPlayUrl,
      'duration': instance.duration,
      'message': instance.message,
      'createTime': instance.createTime,
      'webUrl': instance.webUrl,
      'library': instance.library,
      'user': instance.user,
      'playInfo': instance.playInfo,
      'consumption': instance.consumption,
      'tags': instance.tags,
      'type': instance.type,
      'remark': instance.remark,
      'idx': instance.idx,
      'date': instance.date,
      'descriptionEditor': instance.descriptionEditor,
      'header': instance.header,
      'itemList': instance.itemList,
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    json['id'] as int,
    json['name'] as String,
    json['actionUrl'] as String,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'actionUrl': instance.actionUrl,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    json['icon'] as String,
    json['name'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'icon': instance.icon,
      'name': instance.name,
      'description': instance.description,
    };

Provider _$ProviderFromJson(Map<String, dynamic> json) {
  return Provider(
    json['name'] as String,
    json['alias'] as String,
    json['icon'] as String,
  );
}

Map<String, dynamic> _$ProviderToJson(Provider instance) => <String, dynamic>{
      'name': instance.name,
      'alias': instance.alias,
      'icon': instance.icon,
    };

Cover _$CoverFromJson(Map<String, dynamic> json) {
  return Cover(
    json['feed'] as String,
    json['detail'] as String,
    json['blurred'] as String,
    json['sharing'] as String,
    json['homepage'] as String,
  );
}

Map<String, dynamic> _$CoverToJson(Cover instance) => <String, dynamic>{
      'feed': instance.feed,
      'detail': instance.detail,
      'blurred': instance.blurred,
      'sharing': instance.sharing,
      'homepage': instance.homepage,
    };

WebUrl _$WebUrlFromJson(Map<String, dynamic> json) {
  return WebUrl(
    json['raw'] as String,
    json['forWeibo'] as String,
  );
}

Map<String, dynamic> _$WebUrlToJson(WebUrl instance) => <String, dynamic>{
      'raw': instance.raw,
      'forWeibo': instance.forWeibo,
    };

PlayInfo _$PlayInfoFromJson(Map<String, dynamic> json) {
  return PlayInfo(
    json['name'] as String,
    json['url'] as String,
    json['type'] as String,
    (json['urlList'] as List)
        ?.map((e) => e == null ? null : Url.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlayInfoToJson(PlayInfo instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'type': instance.type,
      'urlList': instance.urlList,
    };

Consumption _$ConsumptionFromJson(Map<String, dynamic> json) {
  return Consumption(
    json['collectionCount'] as int,
    json['shareCount'] as int,
    json['replyCount'] as int,
  );
}

Map<String, dynamic> _$ConsumptionToJson(Consumption instance) =>
    <String, dynamic>{
      'collectionCount': instance.collectionCount,
      'shareCount': instance.shareCount,
      'replyCount': instance.replyCount,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['uid'] as int,
    json['nickname'] as String,
    json['avatar'] as String,
    json['userType'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'userType': instance.userType,
    };

ParentReply _$ParentReplyFromJson(Map<String, dynamic> json) {
  return ParentReply(
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['message'] as String,
  );
}

Map<String, dynamic> _$ParentReplyToJson(ParentReply instance) =>
    <String, dynamic>{
      'user': instance.user,
      'message': instance.message,
    };

Url _$UrlFromJson(Map<String, dynamic> json) {
  return Url(
    json['size'] as int,
  );
}

Map<String, dynamic> _$UrlToJson(Url instance) => <String, dynamic>{
      'size': instance.size,
    };

Header _$HeaderFromJson(Map<String, dynamic> json) {
  return Header(
    json['id'] as int,
    json['icon'] as String,
    json['iconType'] as String,
    json['description'] as String,
    json['title'] as String,
    json['font'] as String,
    json['cover'] as String,
    json['label'] as String,
    json['actionUrl'] as String,
    json['subtitle'] as String,
    (json['labelList'] as List)
        ?.map(
            (e) => e == null ? null : Label.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'iconType': instance.iconType,
      'description': instance.description,
      'title': instance.title,
      'font': instance.font,
      'cover': instance.cover,
      'label': instance.label,
      'actionUrl': instance.actionUrl,
      'subtitle': instance.subtitle,
      'labelList': instance.labelList,
    };

Label _$LabelFromJson(Map<String, dynamic> json) {
  return Label(
    json['text'] as String,
    json['card'] as String,
    json['detial'] as String,
    json['actionUrl'] as String,
  );
}

Map<String, dynamic> _$LabelToJson(Label instance) => <String, dynamic>{
      'text': instance.text,
      'card': instance.card,
      'detial': instance.detial,
      'actionUrl': instance.actionUrl,
    };
