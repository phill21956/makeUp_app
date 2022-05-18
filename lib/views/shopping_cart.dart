import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makeup_shop_app/database/db_model.dart';
import 'package:makeup_shop_app/database/db_prodect_model.dart';
import 'package:makeup_shop_app/views/widgets/shop_card_widget.dart';
import '../controller/product_controller.dart';
import '../models/product_model.dart';
import 'product_details.dart';

class ShoppingCartPage extends StatelessWidget {
  final db = ProductDatabase();
  final ProductModel? product;
  ShoppingCartPage({this.product, Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart',
            style: TextStyle(
                fontFamily: 'avenir',
                fontSize: 20,
                fontWeight: FontWeight.w900)),
      ),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<List<Product>>(
        future: db.getProduct(),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            List<Product>? moviesCatalog =
                snapshot.data!.map((movies) => movies).toList();

            return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height * 1.1),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    physics: const ScrollPhysics(),
                    itemCount: moviesCatalog.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Get.to(
                        () => ProductDetails(
                          id:  productController.productList[index].id,
                          title: productController.productList[index].name,
                          imageLink:
                              productController.productList[index].imageLink,
                          name: productController.productList[index].name,
                          brand: productController.productList[index].brand
                              .toString(),
                          price: productController.productList[index].price!,
                          description:
                              productController.productList[index].description,
                          products: product,
                        ),
                      ),
                      child: ProductCardCopy(
                        id: moviesCatalog[index].id,
                        name: moviesCatalog[index].title,
                        image: moviesCatalog[index].image,
                        price: moviesCatalog[index].price,
                        ratings: moviesCatalog[index].ratings,
                        product: product,
                      ),
                    ),
                  )
                ]));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
