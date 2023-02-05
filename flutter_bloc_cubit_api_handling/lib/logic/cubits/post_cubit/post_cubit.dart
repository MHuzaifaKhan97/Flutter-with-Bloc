import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit_api_handling/data/models/post_model.dart';
import 'package:flutter_bloc_cubit_api_handling/data/repositories/post_repository.dart';
import 'package:flutter_bloc_cubit_api_handling/logic/cubits/post_cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState()) {
    fetchPosts();
  }

  PostRepository _postRepository = PostRepository();
  void fetchPosts() async {
    try {
      List<PostModel> posts = await _postRepository.fetchPosts();
      emit(PostLoadedState(posts));
    } on DioError catch (e) {
      if (e.type == DioErrorType.other)
        emit(PostErrorState(
            "Can't fetch posts, please check your internet conenction!"));
      else {
        emit(PostErrorState(e.message.toString()));
      }
    }
  }
}
