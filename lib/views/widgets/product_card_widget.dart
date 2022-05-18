import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../database/db_model.dart';
import '../../database/db_prodect_model.dart';
import '../../models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final String? name, image;
  final String? price;
  final int? id;
  final double? ratings;
  final ProductModel? product;
  final db = ProductDatabase();
  ProductCardWidget(
      {this.product,
      required this.id,
      required this.name,
      required this.image,
      this.price,
      this.ratings,
      Key? key})
      : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Obx(() {
                    const icon2 = Icon(Icons.favorite_rounded);
                    const icon3 = Icon(Icons.favorite_border);
                    return CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: product!.isFavorite.value ? icon2 : icon3,
                        onPressed: () async {
                          product!.isFavorite.toggle();
                          if (product!.isFavorite.value) {
                            await db.insertProduct(Product(
                                id: product!.id,
                                title: product!.name,
                                price: product!.price,
                                image: product!.imageLink,
                                ratings: product!.rating,
                                isChecked: false));
                          } else {
                            db.deleteProduct(Product(
                                id: product!.id,
                                title: product!.name,
                                price: product!.price,
                                ratings: product!.rating,
                                image: product!.imageLink,
                                isChecked: false));
                          }
                        },
                      ),
                    );
                  }),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              name!,
              maxLines: 2,
              style: const TextStyle(
                  fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if (ratings != null)
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$ratings',
                      // product.rating.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            Text(price!,
                //'\$${product.price}',
                style: const TextStyle(fontSize: 32, fontFamily: 'avenir')),
          ],
        ),
      ),
    );
  }
}
