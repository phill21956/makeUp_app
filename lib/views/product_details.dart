import 'package:flutter/material.dart';
import 'package:makeup_shop_app/models/product_model.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails(
      {required this.title,
      required this.imageLink,
      required this.brand,
      required this.description,
      required this.name,
      this.id,
      required this.price,
      this.products,
      Key? key})
      : super(key: key);
  final String title, imageLink, name, brand, price, description;
  final int? id;
  final ProductModel? products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(title),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(imageLink),
                    fit: BoxFit.contain,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none)),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    brand,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Cost: \$$price',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
