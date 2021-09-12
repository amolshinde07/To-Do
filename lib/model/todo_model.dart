//@dart=2.9
// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

import 'package:uuid/uuid.dart';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  Todo({
    this.id,
    this.title,
    this.desc,
    this.createdAt,
    this.hour,
    this.min,
    this.isCompleted,
  });
  var id = Uuid().v1();
  String title;
  String desc;
  DateTime createdAt;
  bool isCompleted;
  int hour;
  int min;


  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json["title"] == null ? null : json["title"],
    desc: json["desc"] == null ? null : json["desc"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    isCompleted: json["isCompleted"] == null ? null : json["isCompleted"],
    hour: json["hour"] == null ? null : json["hour"],
    min: json["min"] == null ? null : json["min"]
  );

  Map<String, dynamic> toJson() => {
    "id": id==null?Uuid().v1():id,
    "title": title == null ? null : title,
    "desc": desc == null ? null : desc,
    "createdAt": createdAt == null ? null : createdAt,
    "isCompleted": isCompleted == null ? null : isCompleted,
    "hour": hour == null?00: hour,
    "min": min == null?00:min
  };
}
