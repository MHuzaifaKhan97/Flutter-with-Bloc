part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemovedFromCartEvent extends CartEvent {
  final ProductDataModel cartData;
  CartRemovedFromCartEvent({required this.cartData});
}
