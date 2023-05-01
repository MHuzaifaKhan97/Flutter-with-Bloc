import 'package:bloc_cart_app/feature/cart/bloc/cart_bloc.dart';
import 'package:bloc_cart_app/feature/home/model/home_product_data_model.dart';
import 'package:bloc_cart_app/feature/wishlist/bloc/wish_list_bloc.dart';
import 'package:flutter/material.dart';

class WishListTile extends StatelessWidget {
  WishListTile(
      {super.key, required this.productDataModel, required this.wishListBloc});
  final ProductDataModel productDataModel;
  final WishListBloc wishListBloc;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 102, 98, 98)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(productDataModel.imageUrl))),
            ),
            Text(
              productDataModel.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(productDataModel.description),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${productDataModel.price}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          wishListBloc.add(WishListRemovedFromWishListEvent(
                              wishListData: productDataModel));
                        },
                        icon: const Icon(Icons.remove_circle_outline)),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
