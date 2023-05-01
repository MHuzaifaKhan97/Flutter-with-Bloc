import 'package:bloc_cart_app/feature/cart/bloc/cart_bloc.dart';
import 'package:bloc_cart_app/feature/cart/ui/cart_tile_widget.dart';
import 'package:bloc_cart_app/feature/wishlist/bloc/wish_list_bloc.dart';
import 'package:bloc_cart_app/feature/wishlist/ui/wishlist_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatefulWidget {
  WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final WishListBloc wishListBloc = WishListBloc();

  @override
  void initState() {
    wishListBloc.add(WishListInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WishList Items"),
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<WishListBloc, WishListState>(
        bloc: wishListBloc,
        listenWhen: (previous, current) => current is WishListActionState,
        buildWhen: (previous, current) => current is! WishListActionState,
        listener: (context, state) {
          if (state is WishListRemovedFromWishListSuccessState) {}
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Item removed from Wishlist")));
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishListSuccessState:
              final successState = state as WishListSuccessState;
              return ListView.builder(
                  itemCount: successState.wishListItems.length,
                  itemBuilder: (context, index) {
                    return WishListTile(
                        wishListBloc: wishListBloc,
                        productDataModel: successState.wishListItems[index]);
                  });

            default:
          }
          return Container();
        },
      ),
    );
  }
}
