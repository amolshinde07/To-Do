import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test_inherited/model/todo_model.dart';
import 'package:test_inherited/service/todo_service.dart';

class TodoProviderService{

  static void deleteTodo(BuildContext context, index) {
    Provider.of<TodoService>(context, listen: false).deleteTodo(index);
  }

  static void doneTodo(BuildContext context, index) {
    Provider.of<TodoService>(context, listen: false).jobDoneTodo(context: context, index: index);
  }

  static void addTodo(BuildContext context,Todo todo) {
    Provider.of<TodoService>(context, listen: false).addTodo(todo);
  }

  static void editTodo(BuildContext context,Todo todo,int index) {
    Provider.of<TodoService>(context, listen: false).editTodo(todo, index, context);
  }
}