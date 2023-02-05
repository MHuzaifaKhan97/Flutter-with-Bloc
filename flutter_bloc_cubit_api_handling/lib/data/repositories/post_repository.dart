import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_cubit_api_handling/data/models/post_model.dart';
import 'package:flutter_bloc_cubit_api_handling/data/repositories/api/api.dart';

class PostRepository {
  API api = API();
  Future<List<PostModel>> fetchPosts() async {
    try {
      Response response = await api.sendRequest.get("/posts");
      List<dynamic> postMaps = response.data;
      return postMaps.map((post) => PostModel.fromJson(post)).toList();
    } catch (e) {
      throw e;
    }
  }
}
