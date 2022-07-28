import 'dart:convert';

import 'package:etiqa/model/plan_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class MainPageViewModel extends GetxController {
  @override
  void onInit() {
    retrieveProducts();
    super.onInit();
  }

  final box = GetStorage();
  List<Product> products = [];

  clearBox() {
    box.remove("saveList");
  }

  retrieveProducts() async {
    products.clear();
    var json = await box.read("saveList");
    var saveList;
    List<dynamic> oldSavedList = [];

    if (json != null) {
      saveList = jsonDecode(json);
    }

    if (saveList != null) oldSavedList = saveList;

    if (oldSavedList.isNotEmpty) {
      List<Product> nonFilter = [];
      for (var e in oldSavedList) {
        nonFilter.add(Product.fromJson(e));
      }

      products = nonFilter.reversed.toSet().toList();

      refresh();
    }
  }
}
