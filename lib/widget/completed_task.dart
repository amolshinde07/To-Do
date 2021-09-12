//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_inherited/model/todo_model.dart';
import 'package:test_inherited/service/todo_service.dart';
import 'package:test_inherited/widget/side_right_background.dart';
import 'package:test_inherited/widget/slide_left_background.dart';
import 'package:test_inherited/widget/todo_card.dart';
import 'package:test_inherited/widget/todo_op.dart';

import 'empty.dart';
class CompletedTask extends StatefulWidget {
  final String title;
  CompletedTask({this.title});

  @override
  _CompletedTaskState createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  void _deleteTodo(BuildContext context, index) {
    Provider.of<TodoService>(context, listen: false).deleteTodo(index);
  }

  void _doneTodo(BuildContext context, index) {
    Provider.of<TodoService>(context, listen: false).jobDoneTodo(context: context, index: index);
  }

  Future<bool> _showConfirmationDialog(
      BuildContext context, String action, int index) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to Delete $action?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                _deleteTodo(context, index);
                Navigator.pop(context, true);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        '${action} deleted!'))); // showDialog() returns true
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todoList = Provider.of<TodoService>(context).todoCompletedList;
    print(todoList);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.fact_check_outlined))
        ],
      ),
      body: Center(
        child: todoList.isEmpty
            ? Center(
          child: EmptyContainer(),
        )
            : ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return ListTile(title: Dismissible(
                child: TodoCard(
                  todo: todoList[index],
                ),
                key: Key(todoList[index]?.title ?? "rx1001001y"),
                confirmDismiss: (DismissDirection dismissDirection) async {
                  switch (dismissDirection) {
                    case DismissDirection.endToStart:
                      return await _showConfirmationDialog(
                          context, todoList[index].title, index) ==
                          true;
                    case DismissDirection.startToEnd:
                      return await _showConfirmationDialog(
                          context, todoList[index].title, index) ==
                          true;
                    case DismissDirection.horizontal:
                    case DismissDirection.vertical:
                    case DismissDirection.up:
                    case DismissDirection.down:
                      assert(false);
                  }
                  return false;
                },

                background: SlideRightBackground(),
                secondaryBackground: SlideLeftBackground(),
              ),);
            }),
      ),

    );
  }

  Future<bool> _showJobDoneDialog(
      BuildContext context, String action, int index) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make Change to Complete $action?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                _doneTodo(context, index);
                Navigator.pop(context, false);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        '${action} Completed!'))); // showDialog() returns true
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  }
}
