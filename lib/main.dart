import 'package:etiqa/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orietation, deviceType) {
      return GetMaterialApp(
        title: 'Etiqa - Danish Irfan',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPageView(),
      );
    });
  }
}
