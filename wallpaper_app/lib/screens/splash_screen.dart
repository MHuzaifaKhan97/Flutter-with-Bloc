import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/cubit/wallpaper_cubit_cubit.dart';
import 'package:wallpaper_app/extra/constants.dart';
import 'package:wallpaper_app/screens/wallpaper_screen.dart';
import 'package:wallpaper_app/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToWallpaper();
  }

  navigateToWallpaper() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const WallpaperScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(child: Hero(tag: "logo", child: LogoWidget())),
    );
  }
}
