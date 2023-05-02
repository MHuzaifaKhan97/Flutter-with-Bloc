import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflite_multilingual_bloc/features/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            // title: const Text("Todo App SQFlite"),
            title: Text(cubit.titles[cubit.selectedIndex]),
          ),
          // body: Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       // Text(BlocProvider.of<HomeCubit>(context).name),
          //       // or
          //       Text(cubit.name),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           MaterialButton(
          //             color: Colors.teal,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15)),
          //             onPressed: () {
          //               cubit.incrementNumber();
          //             },
          //             child: const Text(
          //               "+",
          //               style: TextStyle(fontSize: 22),
          //             ),
          //           ),
          //           Text(
          //             cubit.number.toString(),
          //             style: const TextStyle(fontSize: 22),
          //           ),
          //           MaterialButton(
          //             color: Colors.red,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15)),
          //             onPressed: () {
          //               cubit.decrementNumber();
          //             },
          //             child: const Text(
          //               "-",
          //               style: TextStyle(fontSize: 28),
          //             ),
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          body: cubit.screens[cubit.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on), label: "Location"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
            currentIndex: cubit.selectedIndex,
            onTap: (index) => cubit.changePage(index),
          ),
        );
      },
    );
  }
}
