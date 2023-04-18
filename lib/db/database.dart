import 'package:flutter_crud/db/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDataBase() async { // Criado depois do task_dao pois deve referenciá-lo.
  var databasePath = await getDatabasesPath();
  final String path = join(databasePath, "task.db");
  return openDatabase(path, onCreate: (db, version) {
    db.execute(TaskDao.tableSql);
  }, version: 1);
}
