import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_multilingual_bloc/controller/cubit/todo_cubit.dart';
import 'package:todo_sqflite_multilingual_bloc/views/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.teal,
          ),
        ),
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state is TodoInsertingIntoDatabaseState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          var cubit = TodoCubit.get(context);

          if (state is TodoGettingDataFromDatabaseState) {
            return cubit.tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: cubit.tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.tasks[index]["title"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  Text(
                                    cubit.tasks[index]["time"],
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        cubit.deleteDataFromDatabase(
                                            id: cubit.tasks[index]['id']!);
                                      },
                                      child: const Icon(Icons.delete))
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                  alignment: AlignmentDirectional.bottomStart,
                                  child: Text(
                                    cubit.tasks[index]["description"],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.warning_amber,
                          size: 32,
                        ),
                        SizedBox(height: 6),
                        Text(
                          'No Task added yet',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
