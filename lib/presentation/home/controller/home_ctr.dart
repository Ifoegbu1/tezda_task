import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tezda_task/core/app_const.dart';
import 'package:tezda_task/core/services/storage_service.dart';
import 'package:tezda_task/presentation/home/model/product_model.dart';
import 'package:tezda_task/utils/app_functions.dart';

class HomeController extends GetxController {
  int selectedHomeTab = 0;
  int selectedFavTab = 0;

  bool isLoaded = false;
  bool productsLoading = false;
  // @override
  // onReady() {
  //   getProducts();

  //   super.onReady();
  // }

  List<ProductModel> filteredProducts = [];

  List<ProductModel> products = [];
  List<String> favCategories = [];

  List<ProductModel> favouriteProducts = [];
  List<ProductModel> filteredFav = [];

  List<String> productCategories = [];

  Future<void> getFavProducts() async {
    favouriteProducts = [];
    favouriteProducts = await StorageService.getfavProductsList();
  }

  Future<void> getProducts() async {
    isLoaded = false;
    selectedHomeTab = 0;

    try {
      Uri uri = Uri.parse('${AppConst.baseUrl}products');
      var response = await http.get(uri);

      switch (response.statusCode) {
        case 200:
          List<dynamic> jsonData = json.decode(response.body);
          filteredProducts.clear();
          products.clear();

          products = jsonData
              .map((product) => ProductModel.fromJson(product))
              .toList();

          await getProductsCategory();
          filterProducts(false);
          getFavProducts();

          isLoaded = true;
          update();

          break;
        default:
      }
    } catch (e) {
      tezdaLog(e);
    }
  }

  Future<void> getProductsCategory() async {
    try {
      Uri uri = Uri.parse('${AppConst.baseUrl}products/categories');
      var response = await http.get(uri);

      switch (response.statusCode) {
        case 200:
          productCategories.clear();
          final List<dynamic> jsonData = json.decode(response.body);
          productCategories = jsonData.map((item) => item.toString()).toList();
          tezdaLog(productCategories);

          break;
        default:
      }
    } catch (e) {
      tezdaLog(e);
    }
  }

  void filterProducts(bool isFav) {
    filteredProducts = products;
    filteredProducts = products
        .where(
            (element) => element.category == productCategories[selectedHomeTab])
        .toList();
    update();
  }

  Future<void> addToOrRemoveFav(ProductModel product) async {
    int index = favouriteProducts.indexWhere((p) => p.id == product.id);
    if (index == -1) {
      favouriteProducts.add(product);
    } else {
      favouriteProducts.removeAt(index);
    }
    update();
    await StorageService.savefavProductsList(favouriteProducts);
  }

  List<ProductModel> getFilteredProductsList(bool isFav) {
    return isFav ? filteredFav : filteredProducts;
  }

  List<ProductModel> getProductsList(bool isFav) {
    return isFav ? favouriteProducts : filteredProducts;
  }

  List<String> getCategories(bool isFav) {
    return isFav ? favCategories : productCategories;
  }

  bool isFavourite(int productId) {
    return favouriteProducts.any((p) => p.id == productId);
  }
}
