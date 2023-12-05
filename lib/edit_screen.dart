import 'package:flutter/material.dart';
import 'package:todo_floor/db/todo.dart';
import 'package:todo_floor/db/todo_dao.dart';
import 'package:todo_floor/db/todo_database.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.id});

  final int id;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late final database;
  late TodoDao todoDao;
  late TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnection();
  }

  getConnection() async {
    database = await $FloorTodoDatabase
        .databaseBuilder("todo_database.db")
        .build(); //connect to database
    todoDao = database
        .todoDao; //connect database with todoDao or use todoDao in database

    //carry data from homescreen to editScreen
    Todo? todo = await this.todoDao.findTodoById(widget.id); //use outside "id"
    setState(() {
      this._textController = TextEditingController(text: todo!.task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Screen"),
      ),
      body: Column(children: [
        Form(
            child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                  key: key,
                  child: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _textController,
                          decoration: InputDecoration(
                              hintText: "Enter Something...",
                              labelText: "Todo_List"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Must not be empty";
                            }
                            return null;
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: OutlinedButton(
                              onPressed: () async {
                                setState(() {
                                  this.todoDao.updateById(
                                      widget.id, _textController.text);
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ))
      ]),
    );
  }
}
