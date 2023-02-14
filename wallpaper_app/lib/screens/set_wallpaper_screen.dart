import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/cubit/wallpaper_cubit_cubit.dart';
import 'package:wallpaper_app/extra/constants.dart';
import 'package:wallpaper_app/extra/location_enum.dart';
import 'package:wallpaper_app/extra/snackbar.dart';
import 'package:wallpaper_app/extra/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/loading_indicator.dart';

class SetWallpaperScreen extends StatefulWidget {
  final WallpaperModel? wallpaper;
  const SetWallpaperScreen({Key? key, required this.wallpaper})
      : super(key: key);

  @override
  State<SetWallpaperScreen> createState() => _SetWallpaperScreenState();
}

class _SetWallpaperScreenState extends State<SetWallpaperScreen> {
  File? wallpaperFile;
  @override
  void initState() {
    super.initState();
    context
        .read<WallpaperCubit>()
        .downloadWallpaper(widget.wallpaper!.original)
        .then((file) {
      setState(() {
        wallpaperFile = file;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<WallpaperCubit, WallpaperState>(
      listener: (context, state) {
        if (state is WallpaperAppliedSuccessState) {
          Snackbar.show(
              context, "Wallpaper applied successfully", ContentType.success);
        } else if (state is WallpaperAppliedFailedState) {
          Snackbar.show(
              context, "Wallpaper applied failed", ContentType.warning);
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          wallpaperFile != null
              ? Image.file(
                  wallpaperFile!,
                  fit: BoxFit.cover,
                )
              : const LoadingIndicator(),
          if (wallpaperFile != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<WallpaperCubit>().setWallPaper(
                            wallpaperFile!.path, WallpaperLocation.home);
                      },
                      child: const Text("Home Screen"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WallpaperCubit>().setWallPaper(
                            wallpaperFile!.path, WallpaperLocation.both);
                      },
                      child: const Text("Both"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WallpaperCubit>().setWallPaper(
                            wallpaperFile!.path, WallpaperLocation.lock);
                      },
                      child: const Text("Lock Screen"),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
              top: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: white,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: black,
                  )))
        ],
      ),
    ));
  }
}
