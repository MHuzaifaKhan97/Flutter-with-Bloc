import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_multilingual_bloc/features/home/cubit/home_cubit.dart';
import 'package:todo_sqflite_multilingual_bloc/features/home/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Multilingual with SQFlite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeCubit()),
        ],
        child: const HomeScreen(),
      ),
      // home: BlocProvider(
      //   create: (context) => HomeCubit(),
      //   child: const HomeScreen(),
      // ),
    );
  }
}
