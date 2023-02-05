import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generate_routes_flutter_cubit/cubits/first_cubit.dart';
import 'package:generate_routes_flutter_cubit/routes.dart';
import 'package:generate_routes_flutter_cubit/screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      initialRoute: "/first",
      // home: BlocProvider(
      //   create: (context) => FirstCubit(),
      //   child: FirstScreen(),
      // ),
    );
  }
}
