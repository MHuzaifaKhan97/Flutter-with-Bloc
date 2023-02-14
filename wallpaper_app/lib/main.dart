import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/cubit/wallpaper_cubit_cubit.dart';
import 'package:wallpaper_app/extra/constants.dart';
import 'package:wallpaper_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperCubit()..getWallpapers(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const SplashScreen(),
      ),
    );
  }
}
