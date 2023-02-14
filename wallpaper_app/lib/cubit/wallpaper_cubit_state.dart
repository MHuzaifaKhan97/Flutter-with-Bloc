part of 'wallpaper_cubit_cubit.dart';

abstract class WallpaperState {}

class WallpaperLoadingState extends WallpaperState {}

class WallpaperLoaadedState extends WallpaperState {
  final List<WallpaperModel> wallpapers;
  WallpaperLoaadedState({required this.wallpapers});
}

class WallpaperError extends WallpaperState {
  final String message;
  WallpaperError(this.message);
}

class WallpaperAppliedSuccessState extends WallpaperState {}

class WallpaperAppliedFailedState extends WallpaperState {}
