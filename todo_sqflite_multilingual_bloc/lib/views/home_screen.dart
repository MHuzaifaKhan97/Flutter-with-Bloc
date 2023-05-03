import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_multilingual_bloc/controller/cubit/todo_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text("Todo App"),
          ),
          body: Center(
              child: Column(
            children: [
              // Create database
              // MaterialButton(
              //     onPressed: () {
              //       cubit.createDatabase();
              //     },
              //     child: const Text("Create Database")),
              // Insert into database
              MaterialButton(
                  onPressed: () {
                    cubit.insertIntoDatabase(
                        title: "Goto Gym",
                        date: "10-04-23",
                        time: "10:00",
                        description: "Goto the gym on time");
                  },
                  child: const Text("Insert into Database")),
              // getting data from database
              MaterialButton(
                  onPressed: () {
                    cubit.gettingDataFromDatabase();
                  },
                  child: const Text("Getting Data From Database")),
              MaterialButton(
                  onPressed: () {
                    cubit.updateDataFromDatabase(
                      title: "Not going gym",
                      date: "10-04-23",
                      time: "10:00",
                      description: "Goto the gym on time",
                      status: "modified",
                      id: 2,
                    );
                  },
                  child: const Text("Update Data From Database")),
              MaterialButton(
                  onPressed: () {
                    cubit.deleteDataFromDatabase(id: 2);
                  },
                  child: const Text("Delete Data From Database")),
            ],
          )),
        );
      },
    );
  }
}
