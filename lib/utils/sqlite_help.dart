import 'package:sqflite/sqflite.dart';

class SqlLiteHelper {
  final sqlFileName = 'db.daily';
  final dailyCache = 'daily_cache';
  Database db;

  // 开启数据库
  void open() async {
    String path = "${await getDatabasesPath()}/$sqlFileName";
    print(path);
    if (db == null) {
      db = await openDatabase(path, version: 1, onCreate: (db, ver) async {
        await db.execute('''
        Create Table daily_cache(
          id integer primary key,
          title text,
          headText text,
          targetDay text,
          imageUrl text,
          remark text
        );
        ''');
      });
    }
  }
}
