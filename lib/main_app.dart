import 'package:flutter/material.dart';
import 'package:flutter_todo/database.dart';
import 'package:flutter_todo/todo.dart';

class MainApp extends StatelessWidget {
  final DB database = DB();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    database.openTheDatabase();

    Future<List<TODO>?> allTodos = database.getAllTodos();

    List<TODO>? myTodo;

    allTodos.then((value) => {
      myTodo=value
    }
    );

//create the ui card for the todos
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: myTodo?.length!=null ? myTodo!.length-1:0,
      itemBuilder: (context, index) {

        return Card(
          child: ,
        )
      },
    );
  }
}
