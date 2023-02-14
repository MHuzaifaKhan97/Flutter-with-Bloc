import 'dart:convert';
import 'dart:io';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_app/extra/constants.dart';
import 'package:wallpaper_app/extra/location_enum.dart';
import 'package:wallpaper_app/extra/wallpaper_model.dart';

part 'wallpaper_cubit_state.dart';

class WallpaperCubit extends Cubit<WallpaperState> {
  WallpaperCubit() : super(WallpaperLoadingState());

  String _lastQuery = 'abstract art';
  List<WallpaperModel> wallpapers = [];
  Future<void> getWallpapers([String? query]) async {
    query == null ? query = _lastQuery : _lastQuery = query;
    emit(WallpaperLoadingState());
    try {
      wallpapers = await _getWallpapers(query);
      emit(WallpaperLoaadedState(wallpapers: wallpapers));
    } catch (e) {
      emit(WallpaperError(e.toString()));
    }
  }

  Future<List<WallpaperModel>> _getWallpapers(String query) async {
    try {
      final Response response = await get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$query&per_page=60"),
          headers: {
            'Authorization': key,
          });
      if (response.statusCode == 200) {
        final List<WallpaperModel> wallpapers = [];
        final Map<String, dynamic> data = jsonDecode(response.body);
        data['photos'].forEach((photo) {
          wallpapers.add(WallpaperModel.fromJson(photo['src']));
        });
        return wallpapers;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<File?> downloadWallpaper(String imagePath) async {
    try {
      final dir = await getExternalStorageDirectory();
      var response = await get(Uri.parse(imagePath));
      var filePath = '${dir!.path}${DateTime.now().toIso8601String()}.jpg';
      final file = File(filePath);
      file.writeAsBytesSync(response.bodyBytes);
      return file;
    } catch (_) {
      return null;
    }
  }

  void setWallPaper(String imagePath, WallpaperLocation location) async {
    try {
      if (location == WallpaperLocation.both) {
        await _setWallpaper(imagePath, WallpaperLocation.home);
        await _setWallpaper(imagePath, WallpaperLocation.lock);
      } else {
        await _setWallpaper(imagePath, location);
      }
      emit(WallpaperAppliedSuccessState());
    } catch (e) {
      emit(WallpaperAppliedFailedState());
    }
  }

  Future<void> _setWallpaper(
      String imagePath, WallpaperLocation location) async {
    await AsyncWallpaper.setWallpaperFromFile(
      filePath: imagePath,
      wallpaperLocation: location.value,
      goToHome: false,
    );
  }
}
