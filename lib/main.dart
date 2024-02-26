import 'package:flutter/material.dart';
import 'package:flutter_todo/database.dart';
import 'package:flutter_todo/main_app.dart';
import 'package:flutter_todo/todo.dart';
import 'package:path/path.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final DB database = DB();

  TextEditingController titleEditBox = TextEditingController();

  TextEditingController detailEditBox = TextEditingController();

  final navigatorState = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorState,
      home: Scaffold(
        body: ,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            displayDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void displayDialog(BuildContext context) {
    final conte = navigatorState.currentState!.overlay?.context;
    showDialog(context: conte ?? context, builder: makeTodo);
  }

  Widget makeTodo(BuildContext context) {
    return SimpleDialog(
      alignment: Alignment.center,
      elevation: 20.0,
      title: Container(
          alignment: Alignment.topCenter, child: const Text(("Add Todo"))),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TextField(
                minLines: 3,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.center,
                controller: titleEditBox,
                decoration: const InputDecoration(
                  hintText: "Enter Title",
                ),
              ),
              TextField(
                  minLines: 3,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.center,
                  controller: detailEditBox,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    hintText: "Enter Detail",
                  )),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: createTodo, child: Text("Save")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"))
          ],
        )
      ],
    );
  }

  void createTodo() {
    TODO newTodo = TODO(titleEditBox.text, detailEditBox.text, DateTime.now());
    database.insertTodo(newTodo).then((success) => {
      success?
    });

  }
}
