import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sqflite_multilingual_bloc/views/update_task_screen.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitialState());

  static TodoCubit get(context) => BlocProvider.of(context);
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var addTaskformKey = GlobalKey<FormState>();
  var updateTaskformKey = GlobalKey<FormState>();
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
        gettingDataFromDatabase(databse);
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
          clearControllers();
          gettingDataFromDatabase(database);
        },
      ).catchError(
        (err) {
          print(err.toString());
        },
      );
    });
  }

  // Getting data from database
  void gettingDataFromDatabase(database) {
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
        emit(TodoUpdateDataFromDatabaseState());
        clearControllers();
        gettingDataFromDatabase(database);
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
        gettingDataFromDatabase(database);
      },
    ).catchError(
      (err) {
        print(err);
      },
    );
  }

  // Change langauage
  changeEnglishToArabic(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('en', 'US')) {
      context.locale = const Locale('ar', 'EG');
    }
    emit(TodoChangeLangToArabicState());
  }

  changeArabicToEnglish(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('ar', 'EG')) {
      context.locale = const Locale('en', 'US');
    }
    emit(TodoChangeLangToEnglishState());
  }

  navigateToUpdate({required int index, required BuildContext context}) {
    titleController.text = tasks[index]['title'];
    timeController.text = tasks[index]['time'];
    dateController.text = tasks[index]['date'];
    descController.text = tasks[index]['description'];
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => UpdateTaskScreen(
              id: tasks[index]['id'],
            )));
  }

  clearControllers() {
    titleController.clear();
    timeController.clear();
    dateController.clear();
    descController.clear();
  }
}
