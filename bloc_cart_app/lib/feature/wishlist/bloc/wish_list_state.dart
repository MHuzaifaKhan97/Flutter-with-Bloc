part of 'wish_list_bloc.dart';

@immutable
abstract class WishListState {}

class WishListInitial extends WishListState {}

class WishListActionState extends WishListState {}

class WishListSuccessState extends WishListState {
  final List<ProductDataModel> wishListItems;
  WishListSuccessState({required this.wishListItems});
}

class WishListRemovedFromWishListSuccessState extends WishListActionState {}
