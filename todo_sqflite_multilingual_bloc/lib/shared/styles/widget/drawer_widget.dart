import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_multilingual_bloc/controller/cubit/todo_cubit.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        var cubit = TodoCubit.get(context);
        return ListView(
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
        );
      },
    );
  }
}
