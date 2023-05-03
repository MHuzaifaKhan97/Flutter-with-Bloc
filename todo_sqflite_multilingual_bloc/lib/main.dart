import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_multilingual_bloc/controller/cubit/todo_cubit.dart';
import 'package:todo_sqflite_multilingual_bloc/shared/styles/themes.dart';
import 'package:todo_sqflite_multilingual_bloc/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoCubit()..createDatabase(),
        )
      ],
      child: MaterialApp(
        title: 'Todo Multilingual with SQFlite',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
