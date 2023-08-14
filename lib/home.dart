import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/model/todoModel.dart';
import 'package:provider_todo_app/provider/todo_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoTextController = TextEditingController();

  Future<void> todoDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Plan The Day',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          content: TextField(
            controller: _todoTextController,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (_todoTextController.text.isEmpty) {
                    return;
                  }
                  context.read<TodoProvider>().addTodoItem(new TODOModel(
                      title: _todoTextController.text, isCompleted: false));
                  _todoTextController.clear();

                  Navigator.pop(context);
                },
                child: Text('Save')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey[10],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Center(
                  child: Text(
                'ToDo Your Day',
                style: TextStyle(fontSize: 23.0, color: Colors.white70),
              )),
            )),
            SizedBox(
              height: 30,
            ),
            Expanded(
                flex: 3,
                child: ListView.builder(
                  itemCount: provider.alltodolist.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: ListTile(
                        onTap: () {
                          provider
                              .todoStatuschange(provider.alltodolist[index]);
                        },
                        leading: MSHCheckbox(
                          onChanged: (selected) {
                            provider
                                .todoStatuschange(provider.alltodolist[index]);
                          },
                          size: 30,
                          value: provider.alltodolist[index].isCompleted,
                        ),
                        title: Text(
                          provider.alltodolist[index].title,
                          style: TextStyle(
                              fontSize: 20.0,
                              decoration:
                                  provider.alltodolist[index].isCompleted ==
                                          true
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            provider.removeTodoItem(provider.alltodolist[index]);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoDialog();
        },
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add, color: Colors.white70),
      ),
    );
  }
}
