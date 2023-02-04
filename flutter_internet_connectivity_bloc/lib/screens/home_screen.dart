import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_connectivity_bloc/blocs/internet_bloc/internet_bloc.dart';
import 'package:flutter_internet_connectivity_bloc/blocs/internet_bloc/internet_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check Internet using Bloc")),
      body: Center(
          // Bloc Builder
          // child: BlocBuilder<InternetBloc, InternetState>(
          //   builder: (context, state) {
          //     if (state is InternetGainedState) {
          //       return const Text("Internet Connected");
          //     } else if (state is InternetLossState) {
          //       return const Text("Internet Lost");
          //     }
          //     return const Text("Loading...");
          //   },
          // ),

          // Bloc Consumer
          child: BlocConsumer<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetGainedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Container(
                  child: Text("Internet Connected"),
                )));
          } else if (state is InternetLossState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Container(
                  child: Text("Internet Lost"),
                )));
          }
        },
        builder: (context, state) {
          if (state is InternetGainedState) {
            return Text("Connected");
          } else if (state is InternetLossState) {
            return Text("Lost");
          }
          return Text("Loading");
        },
      )),
    );
  }
}
