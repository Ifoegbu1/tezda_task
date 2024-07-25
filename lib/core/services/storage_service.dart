import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezda_task/core/app_const.dart';
import 'package:tezda_task/presentation/home/model/product_model.dart';
import 'package:tezda_task/utils/app_functions.dart';

class StorageService {
  StorageService._();
  static late SharedPreferences prefs;
  static StorageService? _instance;

  static Future<StorageService> get instance async {
    if (_instance == null) {
      prefs = await SharedPreferences.getInstance();
      _instance = StorageService._();
    }
    return _instance!;
  }

  static Future<bool> savefavProductsList(
    List<ProductModel> favouriteProducts,
  ) async {
    try {
      final String serializedList =
          jsonEncode(favouriteProducts.map((e) => e.toJson()).toList());
      return await prefs.setString(AppConst.favProductsKey, serializedList);
    } catch (e) {
      tezdaLog('Error saving favProductsList: $e');
      return false;
    }
  }

  static Future<List<ProductModel>> getfavProductsList() async {
    try {
      final String? serializedList = prefs.getString(AppConst.favProductsKey);
      if (serializedList != null) {
        List<dynamic> decodedList = jsonDecode(serializedList);
        return decodedList.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      tezdaLog('Error loading favProducts list: $e');
      return [];
    }
  }

  static void clearFavProducts() {
    prefs.remove(AppConst.favProductsKey);
  }
}
