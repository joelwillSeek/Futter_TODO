import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Future<Database?> db = Future(() => null);

  void openTheDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    db = openDatabase(join(await getDatabasesPath(), "todo.db"),
        onCreate: (db, version) {
      String sql =
          "create table todo(id integer primary key,title varchar,detail varchar,date datetime)";
      db.execute(sql);
    }, version: 1);
  }

  Future<bool> insertTodo(TODO todo) async {
    final innerDb = await db;

    final response = await innerDb?.insert('todo', todo.toMap);

    final bool result;
    if (response == 0) {
      result = false;
    } else {
      result = true;
    }

    return result;
  }

  Future<List<TODO>?> getAllTodo() async {
    final innerDb = await db;

    final List<Map<String, Object?>>? response = await innerDb?.query("todo");
    if (response != null) {
      final List<TODO> mapToTodo = [];

      for (final {
            "id": id as int,
            "title": title as String,
            "detail": detail as String,
            "date": date as DateTime
          } in response) {
        mapToTodo.add(TODO(title, detail, date)); //id));
      }

      return mapToTodo;
    } else {
      if (kDebugMode) print("cant get all todos form db");

      return [];
    }
  }
}
