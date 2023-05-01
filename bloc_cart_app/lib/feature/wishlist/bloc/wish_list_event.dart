part of 'wish_list_bloc.dart';

@immutable
abstract class WishListEvent {}

class WishListInitialEvent extends WishListEvent {}

class WishListRemovedFromWishListEvent extends WishListEvent {
  final ProductDataModel wishListData;
  WishListRemovedFromWishListEvent({required this.wishListData});
}
