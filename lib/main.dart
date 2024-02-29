import 'package:flutter/material.dart';
import 'package:flutter_todo/database.dart';
import 'package:flutter_todo/todo.dart';
import 'package:flutter_todo/todo_Card.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController titleEditBox = TextEditingController();

  TextEditingController detailEditBox = TextEditingController();

  final navigatorState = GlobalKey<NavigatorState>();

  Future<List<TODO>?> allTodo = getAllTodo();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorState,
      home: Scaffold(
        body: FutureBuilder(
          future: allTodo,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                String title =
                    snapshot.data?[index].title.toString() ?? "no data";
                String detail =
                    snapshot.data?[index].detail.toString() ?? "no data";
                String date =
                    snapshot.data?[index].date.toString() ?? "no data";

                return TodoCard(
                  title: title,
                  detail: detail,
                  date: date,
                  getListFromDb: getListFromDb,
                );
              },
            );
          },
        ),
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
            TextButton(
                onPressed: () {
                  if (dialogFieldAreEmpty()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fill All Fields")));
                  } else {
                    createTodo(context);
                    Navigator.of(context).pop();
                  }
                  getListFromDb();
                },
                child: const Text("Save")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  titleEditBox.text = "";
                  detailEditBox.text = "";
                },
                child: const Text("Cancel"))
          ],
        )
      ],
    );
  }

  bool dialogFieldAreEmpty() =>
      titleEditBox.text.trim() == "" && detailEditBox.text.trim() == "";

  void createTodo(BuildContext context) {
    DateTime currentDateAndTime = DateTime.now();

    TODO newTodo = TODO(titleEditBox.text, detailEditBox.text,
        "${currentDateAndTime.month}/${currentDateAndTime.day}/${currentDateAndTime.year}");

    insertTodo(newTodo).then((success) {
      String t;
      if (success != null && success != 0) {
        t = "successful";
      } else {
        t = "unsuccessful";
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));
    });
  }

  String getSuccessString(bool successful) =>
      successful ? "successful" : "unsuccessful";

  void getListFromDb() {
    setState(() {
      allTodo = getAllTodo();
    });
  }
}
