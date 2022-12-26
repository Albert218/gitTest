import 'package:flutter/cupertino.dart';

class Todo {
  String? id;
  String? todoText;
  bool? isDone;
  DateTime? creationDate;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    required this.creationDate,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Morning Exercise',creationDate: DateTime.now(), isDone: true),
      Todo(id: '02', todoText: 'Prepare Food',creationDate: DateTime.now(), isDone: true),
      Todo(id: '03', todoText: 'Read',creationDate: DateTime.now()),
      Todo(id: '04', todoText: ' Bath',creationDate: DateTime.now() ),
      Todo(id: '05', todoText: 'Learn Flutter',creationDate: DateTime.now(), isDone: true),
      Todo(id: '06', todoText: 'Sleep',creationDate: DateTime.now() ),
      Todo(id: '07', todoText: 'Watch Cartoo',creationDate: DateTime.now(), isDone: true),
    ];
  }

  Map<String, dynamic> toMap(){
    return{
         'id':id,
         'title':todoText,
         'creationDate':creationDate.toString(),
         'isChecked':isDone!? 1: 0,
    };
  }

  
}
