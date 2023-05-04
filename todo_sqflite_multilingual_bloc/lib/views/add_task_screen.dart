import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_sqflite_multilingual_bloc/controller/cubit/todo_cubit.dart';
import 'package:todo_sqflite_multilingual_bloc/shared/styles/widget/textformfield.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoInsertingIntoDatabaseState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.teal),
            title: Text(
              'add_Task'.tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: cubit.addTaskformKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                        controller: cubit.titleController,
                        textInputType: TextInputType.text,
                        onFieldSubmitted: (val) {},
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "title_validation".tr();
                          }
                        },
                        labelText: "title".tr(),
                        hintText: "title_hint".tr(),
                        prefixIcon: Icons.title),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                        controller: cubit.timeController,
                        textInputType: TextInputType.datetime,
                        onFieldSubmitted: (val) {},
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            cubit.timeController.text = value!.format(context);
                          }).catchError((err) {
                            cubit.timeController.clear();
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "time_validation".tr();
                          }
                        },
                        labelText: "time".tr(),
                        hintText: "time_hint".tr(),
                        prefixIcon: Icons.watch_later_outlined),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                        controller: cubit.dateController,
                        textInputType: TextInputType.datetime,
                        onFieldSubmitted: (val) {},
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "date_validation".tr();
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
                              cubit.dateController.text =
                                  DateFormat.yMMMd().format(value!);
                            },
                          ).catchError((err) {});
                        },
                        labelText: "date".tr(),
                        hintText: "date_hint".tr(),
                        prefixIcon: Icons.calendar_month),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                        maxLines: 2,
                        controller: cubit.descController,
                        textInputType: TextInputType.text,
                        onFieldSubmitted: (val) {},
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "desc_validation".tr();
                          }
                        },
                        labelText: "description".tr(),
                        hintText: "desc_hint".tr(),
                        prefixIcon: Icons.title),
                    const SizedBox(height: 16),
                    MaterialButton(
                        height: 50,
                        minWidth: double.infinity,
                        color: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          if (cubit.addTaskformKey.currentState!.validate()) {
                            cubit.insertIntoDatabase(
                                title: cubit.titleController.text,
                                date: cubit.dateController.text,
                                time: cubit.timeController.text,
                                description: cubit.descController.text);
                          }
                        },
                        child: Text(
                          "add_Task".tr(),
                          style: const TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
