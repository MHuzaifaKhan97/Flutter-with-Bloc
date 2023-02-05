import 'package:flutter_bloc_cubit_api_handling/data/models/post_model.dart';

abstract class PostState {}

// class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> posts;
  PostLoadedState(this.posts);
}

class PostErrorState extends PostState {
  final String error;
  PostErrorState(this.error);
}
