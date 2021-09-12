//@dart=2.9
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_inherited/model/todo_model.dart';
import 'package:test_inherited/service/provider_service.dart';
import 'package:test_inherited/service/todo_service.dart';
import 'package:test_inherited/widget/utils.dart';

class TodoOperation extends StatefulWidget {
  final Todo todo;
  final int editedIndex;
  final BuildContext context;
  const TodoOperation({Key key, this.todo, this.editedIndex, this.context}) : super(key: key);

  @override
  _TodoOperationState createState() => _TodoOperationState();
}

class _TodoOperationState extends State<TodoOperation> {
  TextEditingController _titleTxtController = TextEditingController();
  TextEditingController _descTxtController = TextEditingController();
  TextEditingController _dateTimeController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.todo!=null? _getEditData():print("create");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget?.todo?.title==null?"Create Todo ": widget.todo.title}"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),


              ),
              controller: _titleTxtController,

            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),


              ),
              controller: _descTxtController,

            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),

                        suffixIcon: IconButton(onPressed: ()=>_selectDate(context),icon: Icon(Icons.date_range),)


                    ),
                    controller: _dateTimeController,

                  ),
                ),
                SizedBox(width: 5,),
                Expanded(child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                      labelText: 'Time',
                      border: OutlineInputBorder(),


                      suffixIcon: IconButton(onPressed: ()=>_selectTime(context),icon: Icon(Icons.access_time_outlined),)


                  ),
                  controller: _timeController,

                )),

              ],
            ),
            SizedBox(height: 30,),
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width/3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: widget.todo==null ? ElevatedButton(onPressed: (){

                  if(getValid()){
                    TodoProviderService.addTodo(context, Todo(
                        title: _titleTxtController.text,
                        desc: _descTxtController.text,
                        createdAt: _selectedDate,
                        hour: selectedTime.hour,
                        min: selectedTime.minute,
                        isCompleted: false));
                    Future.delayed(Duration(seconds: 1), (){
                      Navigator.pop(context);
                    });
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                        content: Text(
                            'All Fields are Mandatory!')));
                  }
                }
                    , child: Text("Add")): ElevatedButton(onPressed: (){
                  TodoProviderService.editTodo(context, Todo(
                      title: _titleTxtController.text,
                      desc: _descTxtController.text,
                      createdAt: _selectedDate,
                      hour: selectedTime.hour,
                      min: selectedTime.minute,
                      isCompleted: false), widget.editedIndex);
                  Future.delayed(Duration(seconds: 1), (){
                    Navigator.pop(context);
                  });
                }
                    , child: Text("Update")))
          ],
        ),
      ),

    );
  }

  bool getValid(){
    if(_titleTxtController.value!=null && _titleTxtController.text!="" && _descTxtController.text!=null &&
        _descTxtController.text!="" && _dateTimeController.text!=null && _dateTimeController.text!="" &&
    _timeController.text!=null && _timeController.text!="") return true;
    else return false;
  }


  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: _selectedDate,
        lastDate: DateTime(4000));
    if(picked != null){
      _selectedDate = picked;
      _dateTimeController.text = Utils.dateToLocalString(_selectedDate);
    }
  }

  Future _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        print(selectedTime);
        _timeController.text = selectedTime.hour.toString() + ' : ' + selectedTime.minute.toString();
        _timeController.text = formatDate(
            DateTime(2020, 9, 9, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();


      });
  }




  _getEditData(){
    setState(() {
      _titleTxtController.text = widget?.todo?.title??"N/A";
      _descTxtController.text = widget?.todo?.title??'N/A';
      _selectedDate = widget?.todo?.createdAt??DateTime.now();
      _dateTimeController.text = Utils.dateToLocalString(_selectedDate);
      selectedTime = TimeOfDay(hour:widget.todo.hour, minute: widget.todo.min);
      _timeController.text = formatDate(
          DateTime(2020, 9, 9, widget.todo.hour, widget.todo.min),
          [hh, ':', nn, " ", am]).toString();
    });

  }
}


