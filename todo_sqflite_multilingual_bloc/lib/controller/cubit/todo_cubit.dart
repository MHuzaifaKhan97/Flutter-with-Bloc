import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);
  List tasks = [];
  // SQFLite
  // Create our Database
  // Create our Database File
  // Create our Database Table
  // Open our Database Table
  Database? database;
  // Creating database
  void createDatabase() {
    // todo.db is path
    openDatabase(
      "newtodos.db",
      version: 1,
      onCreate: (database, version) {
        // here our database is created only for the first time.
        print("The Database is created");
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, description TEXT, status TEXT)')
            .then((value) {
          // the table is create
          print("Table is created");
        }).catchError((err) {
          // in case of any error has occured
          print(err.toString());
        });
      },
      onOpen: (databse) {
        print("Database file is open");
      },
    ).then(
      (value) {
        database = value;
        emit(TodoCreateDatabaseState());
      },
    ).catchError(
      (err) {
        print(err.toString());
      },
    );
  }

  // Insert into database
  void insertIntoDatabase({
    required String title,
    required String date,
    required String time,
    required String description,
    String status = "new",
  }) {
    database!.transaction((txn) async {
      // INSERT INTO tasks
      txn
          .rawInsert('INSERT INTO tasks '
              '(title, date, time, description, status) VALUES '
              '("$title","$date","$time","$description","$status")')
          .then(
        (id) {
          print("$id");
          emit(TodoInsertingIntoDatabaseState());
        },
      ).catchError(
        (err) {
          print(err.toString());
        },
      );
    });
  }

  // Getting data from database
  void gettingDataFromDatabase() {
    tasks = [];
    database!.rawQuery('SELECT * FROM tasks').then(
      (value) {
        print(value);
        value.forEach(
          (element) => tasks.add(element),
        );
        emit(TodoGettingDataFromDatabaseState());
      },
    ).catchError(
      (err) {},
    );
  }

  // Update data from database
  void updateDataFromDatabase({
    required String title,
    required String date,
    required String time,
    required String description,
    required int id,
    String status = "new",
  }) {
    database!
        .update(
            'tasks',
            {
              "title": title,
              "date": date,
              "time": time,
              "description": description,
              "status": status
            },
            where: "id =?",
            whereArgs: [id])
        .then(
      (value) {
        print(value);
        gettingDataFromDatabase();
      },
    ).catchError(
      (err) {
        print(err.toString());
      },
    );
  }

  // Delete data from database
  void deleteDataFromDatabase({int? id}) {
    database!.rawDelete('DELETE from tasks WHERE id = ? ', [id]).then(
      (value) {
        print("$value Deleted Successfully");
        gettingDataFromDatabase();
      },
    ).catchError(
      (err) {
        print(err);
      },
    );
  }
}
