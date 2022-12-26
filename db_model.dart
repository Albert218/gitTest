import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_todo/model/todo.dart';

class DatabaseConnect {
  Database? _database;

//Create a getter and open a connection to database
  Future<Database> get database async {
    //location of our database
    final dbpath = await getDatabasesPath();

    const dbname = 'todo.db';

    // This joins the dbpath and dbname and create a full path for database
    final path = join(dbpath, dbname);

    //open the connection
    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    //we will create the _createDB function separetely

    return _database!;
  }

  //the _createDB function
  Future<void> _createDB(Database db, int version) async {
    //The column created should in this table match the todo fields
    await db.execute('''
  CREATE TABLE todo(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    creationDate TEXT,
    isChecked INTEGER
  )
''');
  }

//function to add data to our database
  Future<void> insertTodo(Todo todo) async {
    //get connection to database
    final db = await database;

//insert the todo
    await db.insert(
      'todo', // the name of our table
      todo.toMap(), //the function we created in our todo model
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = await database;

    //to delete
    await db.delete(
      'todo',
      where: 'id== ?',
      whereArgs: [todo.id],
    );
  }

  //function to fetch all data
  Future<List<Todo>> getTodo() async {
    final db = await database;

    // query the database and save the todo as list of maps
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy:
          'id DESC', // this order the list by id in descending order to display the latest one on top
    );

    //convert items from list of maps to list of todo
    return List.generate(
      items.length,
      (i) => Todo(
        id: items[i]['id'],
        todoText: items[i]['title'],
        creationDate:DateTime.parse( items[i]['creationDate']),
        isDone: items[i]['isChecked'] == 1? true : false,
      ),
    );
  }
}
