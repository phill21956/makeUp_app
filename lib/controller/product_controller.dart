import 'package:get/get.dart';

import '../models/product_model.dart';
import '../services/http_call.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ApiService.fetchProducts();
      productList.assignAll(products);
    } finally {
      isLoading(false);
    }
  }
}
