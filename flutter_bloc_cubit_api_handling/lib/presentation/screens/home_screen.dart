import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit_api_handling/data/models/post_model.dart';
import 'package:flutter_bloc_cubit_api_handling/logic/cubits/post_cubit/post_cubit.dart';
import 'package:flutter_bloc_cubit_api_handling/logic/cubits/post_cubit/post_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Handling"),
      ),
      // body: SafeArea(child: BlocBuilder<PostCubit, PostState>(
      //   builder: (context, state) {
      //     if (state is PostLoadingState) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     if (state is PostLoadedState) {
      //       return postListView(state.posts);
      //     }
      //     return Center(
      //       child: Text("An Error has occured"),
      //     );
      //   },
      // )),
      body: SafeArea(
          child: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is PostErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Container(
                  // child: Text("Internet Lost"),
                  child: Text(state.error),
                )));
          }
        },
        builder: (context, state) {
          if (state is PostLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostLoadedState) {
            return postListView(state.posts);
          }
          return Center(
            child: Text("An Error has occured"),
          );
        },
      )),
    );
  }

  Widget postListView(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        PostModel post = posts[index];
        return ListTile(
          title: Text(post.title!),
          subtitle: Text(post.body!),
        );
      },
    );
  }
}
