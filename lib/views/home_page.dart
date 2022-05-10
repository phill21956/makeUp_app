import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makeup_shop_app/views/widgets/search_box_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../controller/product_controller.dart';
import 'widgets/product_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Home',
            style: TextStyle(
                fontFamily: 'avenir',
                fontSize: 20,
                fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          const SearchBoxWidget(),
          //const Padding(padding: EdgeInsets.all(16), child: SearchBoxWidget()),
          Expanded(child: Obx(() {
            if (productController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: productController.productList.length,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  return ProductTile(productController.productList[index]);
                },
              );
            }
          }))
        ],
      ),
    );
  }
}
