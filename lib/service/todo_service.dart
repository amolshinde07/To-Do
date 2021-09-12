//@dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_inherited/model/todo_model.dart';

class TodoService extends ChangeNotifier{
  Todo _todo = Todo();
  List<Todo> _todoList = [];
  bool loading = false;

  get todoList => _todoList.reversed.toList();
  get todoCompletedList => _todoList.where((element) => element.isCompleted==true).toList().reversed.toList();

  addTodo(Todo todo){
    var _list = _todoList.where((element) =>
    element.title.toLowerCase().trim()==todo.title.toLowerCase().trim());
    if(_list.isEmpty){
      _todoList.add(todo);
      notifyListeners();
    }else{

      Fluttertoast.showToast(
          msg: "${todo.title} is already exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          webPosition: "center",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }

  }

  deleteTodo(int index){
    try {
      _todoList.removeAt(index);
       notifyListeners();
    }catch(e){
      Fluttertoast.showToast(
          msg: "Error to delete",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          webPosition: "center",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }


  }
  editTodo(Todo todo, int index, BuildContext context){
    var _list = _todoList.where((element) => element.id == todo.id);
    if(_list.isNotEmpty){
      _todoList[index]= todo;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Editted!")));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error! can not be updated")));

    }
  }

  jobDoneTodo({BuildContext context , int index}){
    try {
      _todoList[index].isCompleted = true;
      notifyListeners();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error! can not be updated")));
    }


  }





}