import 'package:get/get.dart';

import '../models/brand_model.dart';
import '../services/http_call.dart';

class BrandController extends GetxController {
  var isLoading = true.obs;
  var productList = <BrandModel>[].obs;

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  void fetchBrands() async {
    try {
      isLoading(true);
      var products = await ApiService.fetchBrands();
      productList.assignAll(products);
    } finally {
      isLoading(false);
    }
  }
}
