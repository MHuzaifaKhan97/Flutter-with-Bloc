import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generate_routes_flutter_cubit/cubits/first_cubit.dart';
import 'package:generate_routes_flutter_cubit/cubits/second_cubit.dart';
import 'package:generate_routes_flutter_cubit/cubits/third_cubit.dart';
import 'package:generate_routes_flutter_cubit/screens/first_screen.dart';
import 'package:generate_routes_flutter_cubit/screens/second_screen.dart';
import 'package:generate_routes_flutter_cubit/screens/third_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/first":
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (_) => FirstCubit(),
                  child: const FirstScreen(),
                )));

      case "/second":
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (_) => SecondCubit(),
                  child: SecondScreen(
                    title: arguments["title"],
                  ),
                )));
      case "/third":
        return MaterialPageRoute(
            builder: ((context) => BlocProvider(
                  create: (_) => ThirdCubit(),
                  child: const ThirdScreen(),
                )));
      default:
        null;
    }
  }
}
