import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static const String DB_NAME = "judy_db.db";
  static const String TABLE_WATCH_RECORD = "watch_record";

  static Future<Database> openDatabase() async {
    // await Sqflite.devSetOptions(SqfliteOptions(logLevel: sqfliteLogLevelVerbose));
    return databaseFactory.openDatabase(DB_NAME,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              //观看记录
              await db.execute(
                  'CREATE TABLE $TABLE_WATCH_RECORD(ID INTEGER PRIMARY KEY AUTOINCREMENT,content TEXT)');
            }));
  }
}
