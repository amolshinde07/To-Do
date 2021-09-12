
//@dart=2.9
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:test_inherited/model/todo_model.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;



  const TodoCard({Key key, this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(4.0) ),
      child: Column(
        children: [
          ListTile(
            title: Text(todo?.title==null?"N?A":todo.title.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Container(

            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          Text("Description :", style:TextStyle(color: Colors.grey)),
                          SizedBox(width: 5,),
                          Text(todo?.desc==null?"N/A":todo.desc, style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),

                      SizedBox(height:10 ,),
                      Row(
                        children: [
                          Text("Status :", style:TextStyle(color: Colors.grey)),
                          SizedBox(width: 5,),
                          CircleAvatar(backgroundColor: todo.isCompleted? Colors.green: Colors.red,radius: 5,)



                        ],


                      ),
                      SizedBox(height:14 ,),


                    ],),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Row(
                      //   children: [
                      //     Text("Age Limit :", style:TextStyle(color: Colors.grey)),
                      //     SizedBox(width: 5,),
                      //     Text(min_age_limit.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                      //
                      //
                      //
                      //   ],
                      //
                      //
                      // ),
                      //
                      // SizedBox(height:10 ,),

                      Row(
                        children: [
                          Text("Time:", style:TextStyle(color: Colors.grey)),
                          SizedBox(width: 5,),
                          Text(formatDate(
                              DateTime(2020, 9, 9, todo?.hour??00, todo?.min??00),
                              [hh, ':', nn, " ", am]).toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],),



                ],
              ),

            ],),


          ),

          // Padding(
          //   padding: const EdgeInsets.all(10.0) ,
          //   child: IntrinsicHeight(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Column(children: [
          //
          //               Text("Address", style:TextStyle(color: Colors.grey), maxLines: 3,),
          //
          //               SizedBox(height: 10,),
          //
          //               // Text(address, style : TextStyle(fontWeight: FontWeight.bold))
          //             ],
          //
          //             ),
          //
          //
          //
          //
          //           ],
          //         ),
          //
          //
          //
          //
          //
          //
          //
          //
          //
          //       ],
          //
          //
          //
          //     ),
          //   ),
          //
          // ),
          //
          // Divider(),
          //
          // Padding(
          //   padding: const EdgeInsets.all(10.0) ,
          //   child: IntrinsicHeight(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //
          //         Row(
          //           children: [
          //             Column(children: [
          //
          //               Text("1st Dose", style:TextStyle(color: Colors.grey),),
          //
          //               SizedBox(height: 10,),
          //
          //               firstDose==0?
          //
          //               Text("Not Available", style : TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
          //                   :Text(firstDose, style : TextStyle(fontWeight: FontWeight.bold, color: Colors.green))
          //             ],
          //
          //             ),
          //
          //
          //             VerticalDivider()
          //
          //
          //           ],
          //         ),
          //
          //         Row(
          //           children: [
          //             Column(children: [
          //
          //               Text("2nd Dose", style:TextStyle(color: Colors.grey),),
          //
          //               SizedBox(height: 10,),
          //
          //               secDose==0?
          //
          //               Text("Not Available", style : TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
          //                   :Text(secDose, style : TextStyle(fontWeight: FontWeight.bold, color: Colors.green))
          //             ],
          //
          //             ),
          //
          //
          //             VerticalDivider()
          //
          //
          //           ],
          //         ),
          //
          //         Row(
          //           children: [
          //             Column(children: [
          //
          //               Text("Fee", style:TextStyle(color: Colors.grey),),
          //
          //               SizedBox(height: 10,),
          //
          //               fee=="0"?
          //
          //               Text("Free", style : TextStyle(fontWeight: FontWeight.bold, color: Colors.green))
          //                   :Text("${fee} /-", style : TextStyle(fontWeight: FontWeight.bold))
          //             ],
          //
          //             ),
          //
          //
          //
          //
          //
          //           ],
          //         ),
          //
          //
          //
          //
          //
          //       ],
          //
          //
          //
          //     ),
          //   ),
          //
          // )
        ],
      ),
    );
  }
}