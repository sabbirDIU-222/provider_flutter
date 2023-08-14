import 'package:flutter/material.dart';

import '../model/todoModel.dart';

class TodoProvider extends ChangeNotifier{

   final List<TODOModel> _todolist = [];

   List<TODOModel> get alltodolist => _todolist;

   void addTodoItem(TODOModel todoModel){
     _todolist.add(todoModel);
     notifyListeners();
   }

   void todoStatuschange(TODOModel todoModel){
     final index = _todolist.indexOf(todoModel);
     _todolist[index].toggleCompleted();
     notifyListeners();
   }


   void removeTodoItem(TODOModel todoModel){
     int index = _todolist.indexOf(todoModel);

     _todolist.removeAt(index);
     notifyListeners();
   }

}