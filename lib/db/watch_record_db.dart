import 'package:sqflite/sqflite.dart';
import 'package:ty/db/db_helper.dart';
import 'package:ty/model/bean/home_bean.dart';
import 'dart:convert' as convert;

class WatchRecordDb {
  WatchRecordDb._();

  static void saveWatchRecord(Item item) async {
    Database database = await DbHelper.openDatabase();

    String content = convert.jsonEncode(item.toJson());
    Map<String, dynamic> values = {"content": content};

    print("values:$values");

    int deleteResult = await database.delete(DbHelper.TABLE_WATCH_RECORD,
        where: "content =?", whereArgs: [content]);

//    print("deleteResult:$deleteResult");

    int insertResult =
        await database.insert(DbHelper.TABLE_WATCH_RECORD, values);

//    print("insertResult:$insertResult");

    database.close();
  }

  static Future<List<Item>> queryWatchRecordList() async {
    Database database = await DbHelper.openDatabase();

    //查询时间倒序、最大查询20条
    List<Map<String, dynamic>> result = await database
        .query(DbHelper.TABLE_WATCH_RECORD, orderBy: "ID DESC", limit: 20);
    return result.map((item) {
      Map<String, dynamic> content = convert.jsonDecode(item["content"]);
      return Item.fromJson(content);
    }).toList();
  }
}
