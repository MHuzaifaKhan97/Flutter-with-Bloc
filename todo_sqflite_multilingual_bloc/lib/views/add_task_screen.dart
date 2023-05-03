import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_sqflite_multilingual_bloc/controller/cubit/todo_cubit.dart';
import 'package:todo_sqflite_multilingual_bloc/shared/styles/widget/textformfield.dart';

class AddTaskScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Add Your Task",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextFormField(
                      controller: titleController,
                      textInputType: TextInputType.text,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please add your title";
                        }
                      },
                      labelText: "Title",
                      hintText: "Add your title",
                      prefixIcon: Icons.title),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                      controller: timeController,
                      textInputType: TextInputType.datetime,
                      onFieldSubmitted: (val) {},
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          timeController.text = value!.format(context);
                        }).catchError((err) {
                          timeController.clear();
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please add your time";
                        }
                      },
                      labelText: "Time",
                      hintText: "Add your Time",
                      prefixIcon: Icons.watch_later_outlined),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                      controller: dateController,
                      textInputType: TextInputType.datetime,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please add your date";
                        }
                      },
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse("2050-12-30"))
                            .then(
                          (value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          },
                        ).catchError((err) {});
                      },
                      labelText: "Date",
                      hintText: "Add your date",
                      prefixIcon: Icons.calendar_month),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                      maxLines: 5,
                      controller: descController,
                      textInputType: TextInputType.text,
                      onFieldSubmitted: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please add your description";
                        }
                      },
                      labelText: "Description",
                      hintText: "Add your description",
                      prefixIcon: Icons.title),
                  const SizedBox(height: 16),
                  MaterialButton(
                      height: 50,
                      minWidth: double.infinity,
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        cubit.insertIntoDatabase(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text,
                            description: descController.text);
                      },
                      child: const Text(
                        "Add Task",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
