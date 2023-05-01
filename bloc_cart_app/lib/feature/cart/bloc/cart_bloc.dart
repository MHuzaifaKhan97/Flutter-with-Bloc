import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/data/cart_items.dart';
import 'package:bloc_cart_app/feature/home/model/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemovedFromCartEvent>(cartRemovedFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemovedFromCartEvent(
      CartRemovedFromCartEvent event, Emitter<CartState> emit) {
    cartItems.removeWhere((element) => element.id == event.cartData.id);
    emit(CartRemovedFromCartSuccessState());
    emit(CartSuccessState(cartItems: cartItems));
  }
}
