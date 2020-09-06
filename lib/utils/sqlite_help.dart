import 'package:daily/model/daily.dart';
import 'package:sqflite/sqflite.dart';

class SqlLiteHelper {
  final sqlFileName = 'db.daily';
  final dailyTable = 'daily_cache';
  Database db;

  // 开启数据库
  Future<void> open() async {
    String path = "${await getDatabasesPath()}/$sqlFileName";
    print(path);
    if (db == null) {
      db = await openDatabase(path, version: 1, onCreate: (db, ver) async {
        await db.execute('''
        Create Table daily_cache(
          id integer primary key autoincrement,
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

  // inert
  Future<void> insert(Daliy daliy) async {
    await db.insert(
      dailyTable,
      daliy.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // queryAll
  Future<List<Daliy>> queryAll() async {
    final List<Map<String, dynamic>> maps = await db.query(dailyTable);
    return List.generate(maps.length, (i) {
      return Daliy(
        id: maps[i]['id'],
        title: maps[i]['title'],
        headText: maps[i]['headText'],
        targetDay: maps[i]['targetDay'],
        imageUrl: maps[i]['imageUrl'],
        remark: maps[i]['remark'],
      );
    });
  }

  // update
  Future<void> update(Daliy daliy) async {
    await db.update(
      dailyTable,
      daliy.toMap(),
      where: "id = ?",
      whereArgs: [daliy.id],
    );
  }

  // delete
  Future<void> delete(Daliy daliy) async {
    await db.delete(
      dailyTable,
      where: "id = ?",
      whereArgs: [daliy.id],
    );
  }
}
