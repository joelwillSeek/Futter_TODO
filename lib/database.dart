import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> db = openTheDatabase();

Future<Database> openTheDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  db = openDatabase(join(await getDatabasesPath(), "todo.db"),
      onCreate: (db, version) {
    String sql =
        "create table todo(title varchar primary key,detail varchar,date varchar)";
    db.execute(sql);
  }, version: 1);

  return db;
}

Future<int?> insertTodo(TODO todo) async {
  final innerDb = await db;

  final response = await innerDb.insert('todo', todo.toMap);

  if (kDebugMode) {
    print(response.toString());
  }

  return response;
}

Future<List<TODO>?> getAllTodo() async {
  final innerDb = await db;

  final List<Map<String, Object?>> response =
      await innerDb.rawQuery("select * from todo");

  final List<TODO> mapToTodo = [];

  for (int i = 0; i < response.length; i++) {
    String title = response[i]["title"] as String;
    String detail = response[i]["detail"] as String;
    String date = response[i]["date"] as String;
    mapToTodo.add(TODO(title, detail, date));
  }

  return mapToTodo;
}
