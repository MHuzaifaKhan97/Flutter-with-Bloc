import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_connectivity_cubit/cubit/internet_cubit.dart';
import 'package:flutter_internet_connectivity_cubit/cubit/internet_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Check Internet using Cubit"),
        ),
        // bloc builder
        // body: Center(child: BlocBuilder<InternetCubit, InternetState>(
        //   builder: (context, state) {
        //     if (state == InternetState.Gained) {
        //       return const Text("Internet Connected");
        //     } else if (state == InternetState.Loss) {
        //       return const Text("Internet Lost");
        //     }
        //     return const Text("Loading...");
        //   },
        // )));
        body: Center(
            child: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state == InternetState.Gained) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Container(
                    child: Text("Internet Connected"),
                  )));
            } else if (state == InternetState.Loss) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Container(
                    child: Text("Internet Lost"),
                  )));
            }

            // return const Text("Loading...");
          },
          child: Text("Internet Status"),
        )));
  }
}
