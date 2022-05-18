import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makeup_shop_app/database/db_model.dart';
import 'package:makeup_shop_app/models/product_model.dart';
import '../../controller/product_controller.dart';
import '../product_details.dart';
import 'product_card_widget.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final db = ProductDatabase();
  ProductTile(this.product, {Key? key}) : super(key: key);
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.to(
              () => ProductDetails(
                title: product.name,
                imageLink: product.imageLink,
                name: product.name,
                brand: product.brand.toString(),
                price: product.price!,
                description: product.description,
              ),
            ),
        child: ProductCardWidget(
          id: product.id,
          name: product.name,
          image: product.imageLink,
          price: product.price,
          ratings: product.rating,
          product: product,
        ));
  }
}

