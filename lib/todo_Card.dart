import 'package:flutter/material.dart';
import 'package:flutter_todo/database.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String detail;
  final String date;
  final Function getListFromDb;

  final TextEditingController updateDetailEditText = TextEditingController();

  TodoCard(
      {super.key,
      required this.title,
      required this.detail,
      required this.date,
      required this.getListFromDb});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails tapUpDetails) {
        updateTodoDialogShower(context);
      },
      child: Card(
          child: Column(
        children: [
          Text(title),
          Text(detail),
          Text(date),
          TextButton(
            onPressed: () {
              deleteTodo(title).then((response) {
                String isDeleted = "Not Deleted";
                if (response != 0) {
                  isDeleted = "Deleted";
                }

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(isDeleted)));
              });

              getListFromDb();
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
                textStyle:
                    MaterialStatePropertyAll(TextStyle(color: Colors.white))),
            child: const Text(
              "delete",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      )),
    );
  }

  void updateTodoDialogShower(BuildContext context) {
    showDialog(
      context: context,
      builder: makeDialog,
    );
  }

  Widget makeDialog(BuildContext context) {
    return SimpleDialog(
      alignment: Alignment.center,
      elevation: 20.0,
      title: Container(
          alignment: Alignment.topCenter, child: const Text(("Update Todo"))),
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
                  controller: updateDetailEditText,
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
                    String isUpdated = "Did Not Updated";
                    updateTodo(updateDetailEditText.text, title)
                        .then((response) {
                      if (response != 0) {
                        isUpdated = "Updated";
                      }
                    });

                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(isUpdated)));
                    Navigator.of(context).pop();
                  }
                  getListFromDb();
                },
                child: const Text("Save")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  updateDetailEditText.text = "";
                },
                child: const Text("Cancel"))
          ],
        )
      ],
    );
  }

  bool dialogFieldAreEmpty() => updateDetailEditText.text.trim() == "";
}
