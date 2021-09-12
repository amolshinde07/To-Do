//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_inherited/service/provider_service.dart';
import 'package:test_inherited/service/todo_service.dart';
import 'package:test_inherited/widget/completed_task.dart';
import 'package:test_inherited/widget/empty.dart';
import 'package:test_inherited/widget/side_right_background.dart';
import 'package:test_inherited/widget/slide_left_background.dart';
import 'package:test_inherited/widget/todo_op.dart';
import 'package:test_inherited/widget/todo_card.dart';
import 'package:http/http.dart' as http;

import 'model/todo_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TodoService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          buttonColor: Colors.blueGrey,
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey) ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: "Assignment"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


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
                TodoProviderService.deleteTodo(context, index);
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
    List<Todo> todoList = Provider.of<TodoService>(context).todoList;
    print(todoList);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CompletedTask(title: "Completed Task",)),
            );
          }, icon: Icon(Icons.fact_check_outlined))
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
                          return await _showJobDoneDialog(
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
                  ), trailing: Wrap(
                    children: [
                      InkWell(onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TodoOperation(todo: todoList[index] , context: context,editedIndex: index,)),
                        );

                      },child: Icon(Icons.edit, color: Colors.grey,)),

                    ],
                  ),);
                }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TodoOperation()),
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add),
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
                TodoProviderService.doneTodo(context, index);
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





