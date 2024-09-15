import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/client_controller.dart';
import 'package:quick_invoice/controller/estimate_controller.dart';
import 'package:quick_invoice/controller/invoice_controller.dart';
import 'package:quick_invoice/controller/item_controller.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';

void main() async {
  await Hive.initFlutter();
  await BusinessController().initAllBoxes();
   Get.put(InvoiceController());//invoice controller 
   Get.put(EstimateController());// estimate controller
   Get.put(ItemController()); // item controller 
   Get.put(ClientController()); // client controller
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
   
    final MainController mainController = Get.put(MainController());
    return Obx(
      () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppRoute.routes,
          initialRoute: AppRoute.splashScreen,
          theme: mainController.isDark.value? AppTheme.darkTheme():AppTheme.lightTheme(),
        );
      }
    );
  }
}
