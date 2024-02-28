import 'package:flutter/material.dart';
import 'package:flutter_todo/database.dart';
import 'package:flutter_todo/todo.dart';

class TheAPP extends StatefulWidget {
  const TheAPP({super.key});

  @override
  State<TheAPP> createState() => _TheAPPState();
}

class _TheAPPState extends State<TheAPP> {
  @override
  Widget build(BuildContext context) {
    Future<List<TODO>?> allTodo = getAllTodo();

    List<TODO>? myTodo;

    allTodo.then((value) {
      myTodo = value;
    });

//create the ui card for the todos
    return FutureBuilder(
      future: allTodo,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            String title = snapshot.data?[index].title.toString() ?? "no data";
            String detail =
                snapshot.data?[index].detail.toString() ?? "no data";
            String date = snapshot.data?[index].date.toString() ?? "no data";

            return Card(
                child: Column(
              children: [Text(title), Text(detail), Text(date)],
            ));
          },
        );
      },
    );
  }
}
