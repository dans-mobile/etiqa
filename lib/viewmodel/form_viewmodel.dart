import 'dart:convert';

import 'package:etiqa/model/plan_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FormViewModel extends GetxController {
  final box = GetStorage();
  late String selectedProduct;

  RxBool isPlanSelected = false.obs;
  RxBool isChildSelected = false.obs;

  ChildPlan? selectedChildPlan;
  List<ChildPlan> selectedChildPlans = <ChildPlan>[].obs;

  RxBool showDependentForm = false.obs;
  Dependant? selectedDependent;
  List<Dependant> selectedDependents = <Dependant>[].obs;

  List<Product> products = [];

  void addChildPlan() {
    if (selectedChildPlan != null) {
      print('Selected Child Plan: ${selectedChildPlan!.toJson()}');
      selectedChildPlans.add(selectedChildPlan!);
      selectedChildPlan = null;
      refresh();
    }
  }

  void addDependant(Dependant dependant) {
    selectedDependent = dependant;
    selectedDependents.add(selectedDependent!);
    selectedDependent = null;
    refresh();
  }

  void cancelChildPlan() {
    selectedChildPlan = null;
    refresh();
  }

  void cancelDependant() {
    showDependentForm.value = false;
    refresh();
  }

  void generateProduct() {
    int id = DateTime.now().microsecondsSinceEpoch;

    print("id: $id");

    Product product = Product(
        id: id,
        name: selectedProduct,
        childPlans: selectedChildPlans,
        dependants: selectedDependents);

    products.add(product);
    saveList(products);
    Get.back();
  }

  saveList(List<dynamic> listNeedToSave) {
    var json = box.read("saveList");
    var saveList;

    if (json != null) saveList = jsonDecode(json);

    List<dynamic> oldSavedData = [];

    if (saveList != null) oldSavedData = saveList;

    if (oldSavedData.isNotEmpty) {
      List<dynamic> oldSavedList = oldSavedData;

      oldSavedList.addAll(listNeedToSave);

      return box.write("saveList", jsonEncode(oldSavedList));
    } else {
      return box.write("saveList", jsonEncode(listNeedToSave));
    }
  }

  void clearAll() {
    selectedProduct = "";
    isPlanSelected.value = false;
    isChildSelected.value = false;
    selectedChildPlan = null;
    selectedChildPlans = [];
    showDependentForm.value = false;
    selectedDependent = null;
    selectedDependents = [];
    products = [];
  }
}
