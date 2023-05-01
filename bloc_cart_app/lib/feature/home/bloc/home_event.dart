part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishListButtonClickEvent extends HomeEvent {
  ProductDataModel clickedProduct;
  HomeProductWishListButtonClickEvent({required this.clickedProduct});
}

class HomeProductCartButtonClickEvent extends HomeEvent {
  ProductDataModel clickedProduct;
  HomeProductCartButtonClickEvent({required this.clickedProduct});
}

class HomeProductWishListNavigateEvent extends HomeEvent {}

class HomeProductCartNavigateEvent extends HomeEvent {}
