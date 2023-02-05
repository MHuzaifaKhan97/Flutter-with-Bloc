import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generate_routes_flutter_cubit/cubits/second_cubit.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => BlocProvider(
                //               create: (context) => ThirdCubit(),
                //               child: const ThirdScreen(),
                //             ))));
                Navigator.pushNamed(context, "/third");
              },
              icon: const Icon(Icons.arrow_forward_outlined))
        ],
      ),
      body: Center(
        child: BlocBuilder<SecondCubit, int>(
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
          BlocProvider.of<SecondCubit>(context).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
