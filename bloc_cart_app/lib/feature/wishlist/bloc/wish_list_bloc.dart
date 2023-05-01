import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/data/wishlist_items.dart';
import 'package:bloc_cart_app/feature/home/model/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial()) {
    on<WishListInitialEvent>(wishListInitialEvent);
    on<WishListRemovedFromWishListEvent>(wishListRemovedFromWishListEvent);
  }

  FutureOr<void> wishListInitialEvent(
      WishListInitialEvent event, Emitter<WishListState> emit) {
    emit(WishListSuccessState(wishListItems: wishListItems));
  }

  FutureOr<void> wishListRemovedFromWishListEvent(
      WishListRemovedFromWishListEvent event, Emitter<WishListState> emit) {
    wishListItems.removeWhere((element) => element.id == event.wishListData.id);
    emit(WishListRemovedFromWishListSuccessState());
    emit(WishListSuccessState(wishListItems: wishListItems));
  }
}
