import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_multilingual_bloc/controller/cubit/todo_cubit.dart';
import 'package:todo_sqflite_multilingual_bloc/views/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
