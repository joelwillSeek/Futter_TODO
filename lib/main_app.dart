import 'package:flutter/material.dart';
import 'package:flutter_todo/database.dart';
import 'package:flutter_todo/todo.dart';

class TheAPP extends StatelessWidget {
  final DB database;

  const TheAPP({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    database.openTheDatabase();

    Future<List<TODO>?> allTodo = database.getAllTodo();

    List<TODO>? myTodo;

    allTodo.then((value) => {myTodo = value});

//create the ui card for the todos
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: myTodo?.length != null ? myTodo!.length - 1 : 0,
      itemBuilder: (context, index) {
        // int? id = myTodo?[index].id;
        String? title = myTodo?[index].title;
        String? detail = myTodo?[index].detail;
        DateTime? date = myTodo?[index].date;

        return Card(
          child: Row(children: [
            //Text(id.toString()),
            Text(title ?? "No Title"),
            Text(detail!),
            Text("${date?.month}/${date?.day}/${date?.year}")
          ]),
        );
      },
    );
  }
}
