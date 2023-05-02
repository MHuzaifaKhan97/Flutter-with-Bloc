import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  // Example 01 Counter Example

  // String name = "Hello John";
  // int number = 0;
  // void incrementNumber() {
  //   number++;
  //   emit(HomeNumberIncreaseState());
  //   print(number);
  // }

  // void decrementNumber() {
  //   if (number != 0) {
  //     number--;
  //   }
  //   emit(HomeNumberDecreaseState());

  //   print(number);
  // }

  // Example 02 BottomNavigationBar
  int selectedIndex = 0;
  List<Widget> screens = [
    const Center(
      child: Text("Home Screen"),
    ),
    const Center(
      child: Text("Location Screen"),
    ),
    const Center(
      child: Text("Setting Screen"),
    ),
  ];
  List<String> titles = ["Home Screen", "Location Screen", "Setting Screen"];

  void changePage(int index) {
    selectedIndex = index;
    emit(HomeChangeBottomNavState());
  }
}
