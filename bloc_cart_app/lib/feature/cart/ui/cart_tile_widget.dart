import 'package:bloc_cart_app/feature/cart/bloc/cart_bloc.dart';
import 'package:bloc_cart_app/feature/home/model/home_product_data_model.dart';
import 'package:flutter/material.dart';

class CartTileWidget extends StatelessWidget {
  CartTileWidget(
      {super.key, required this.productDataModel, required this.cartBloc});
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.7),
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
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              productDataModel.description,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${productDataModel.price}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          cartBloc.add(CartRemovedFromCartEvent(
                              cartData: productDataModel));
                        },
                        icon: const Icon(Icons.remove_circle_outline,
                            color: Colors.white)),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
