import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generate_routes_flutter_cubit/cubits/first_cubit.dart';
import 'package:generate_routes_flutter_cubit/cubits/second_cubit.dart';
import 'package:generate_routes_flutter_cubit/screens/second_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Screen"),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => BlocProvider(
                //               create: (context) => SecondCubit(),
                //               child: const SecondScreen(),
                //             ))));
                Navigator.pushNamed(context, "/second",
                    arguments: {"title": "Second Screen"});
              },
              icon: const Icon(Icons.arrow_forward_outlined))
        ],
      ),
      body: Center(
        child: BlocBuilder<FirstCubit, int>(
          builder: (context, state) {
            return Text(
              state.toString(),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<FirstCubit>(context).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
