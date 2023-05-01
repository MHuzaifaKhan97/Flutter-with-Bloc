import 'package:bloc_cart_app/feature/home/bloc/home_bloc.dart';
import 'package:bloc_cart_app/feature/home/model/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
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
                          homeBloc.add(HomeProductWishListButtonClickEvent(
                              clickedProduct: productDataModel));
                        },
                        icon: const Icon(Icons.favorite_outline)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeProductCartButtonClickEvent(
                              clickedProduct: productDataModel));
                        },
                        icon: const Icon(Icons.shopping_bag_outlined))
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
