import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_multilingual_bloc/controller/cubit/todo_cubit.dart';
import 'package:todo_sqflite_multilingual_bloc/views/add_task_screen.dart';
import 'package:todo_sqflite_multilingual_bloc/views/update_task_screen.dart';

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
            title: Text(
              'task_App'.tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "./assets/images/todo_icon.png",
                        scale: 26,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'task_App'.tr(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('English'),
                  onTap: () {
                    cubit.changeArabicToEnglish(context);
                  },
                ),
                ListTile(
                  title: const Text('عربي'),
                  onTap: () {
                    cubit.changeEnglishToArabic(context);
                  },
                ),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! TodoLoadingDataFromDatabaseState,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            ),
            builder: (context) {
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
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              cubit.deleteDataFromDatabase(
                                                  id: cubit.tasks[index]
                                                      ['id']!);
                                            },
                                            child: const Icon(Icons.delete)),
                                        const SizedBox(width: 8),
                                        InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          UpdateTaskScreen(
                                                            id: cubit.tasks[
                                                                index]['id'],
                                                          )));
                                            },
                                            child: const Icon(Icons.edit)),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                    alignment: AlignmentDirectional.bottomStart,
                                    child: Text(
                                      cubit.tasks[index]["description"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      cubit.tasks[index]["date"],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      cubit.tasks[index]["time"],
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                )
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
                            '',
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
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
      },
    );
  }
}
