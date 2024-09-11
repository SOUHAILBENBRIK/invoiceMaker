import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainController extends GetxController {
  RxString businessName = "".obs;
  RxInt homeIndex = 0.obs;
  RxBool isTaxable = false.obs;
  

  late TextEditingController clientName;
  late TextEditingController phoneNumber;
  late TextEditingController email;
  late TextEditingController address;

 
  

  void changeIsTaxible() {
    isTaxable.value = !isTaxable.value;
  }

 
  void onChange(String value) {
    businessName.value = value;
  }

  void onChnageIndex(int value) {
    homeIndex.value = value;
  }
}
