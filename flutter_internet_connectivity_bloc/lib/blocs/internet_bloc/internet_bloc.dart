import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internet_connectivity_bloc/blocs/internet_bloc/internet_event.dart';
import 'package:flutter_internet_connectivity_bloc/blocs/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  // InternetBloc(super.initialState);
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLossState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });

    @override
    Future<void> close() {
      _connectivitySubscription?.cancel();
      return super.close();
    }
  }
}
