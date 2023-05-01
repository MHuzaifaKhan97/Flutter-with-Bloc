import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/data/cart_items.dart';
import 'package:bloc_cart_app/data/groceries_data.dart';
import 'package:bloc_cart_app/data/wishlist_items.dart';
import 'package:bloc_cart_app/feature/home/model/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishListNavigateEvent>(homeProductWishListNavigateEvent);
    on<HomeProductCartNavigateEvent>(homeProductCartNavigateEvent);
    on<HomeProductWishListButtonClickEvent>(
        homeProductWishListButtonClickEvent);
    on<HomeProductCartButtonClickEvent>(homeProductCartButtonClickEvent);
  }
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(e['id'], e['name'], e['description'],
                e['price'], e['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeProductWishListNavigateEvent(
      HomeProductWishListNavigateEvent event, Emitter<HomeState> emit) {
    print("Wishlist Navigate clicked");
    emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeProductCartNavigateEvent(
      HomeProductCartNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart Navigate clicked");
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishListButtonClickEvent(
      HomeProductWishListButtonClickEvent event, Emitter<HomeState> emit) {
    print("Wishlist clicked");
    wishListItems.add(event.clickedProduct);
    emit(HomeProductItemWishListedActionState());
  }

  FutureOr<void> homeProductCartButtonClickEvent(
      HomeProductCartButtonClickEvent event, Emitter<HomeState> emit) {
    print("Cart clicked");
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartListedActionState());
  }
}
