import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_connectivity_cubit/cubit/internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;
  InternetCubit() : super(InternetState.Initial) {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        emit(InternetState.Gained);
      } else {
        emit(InternetState.Loss);
      }
    });
  }
  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
