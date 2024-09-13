import 'package:get/get.dart';


class MainController extends GetxController {
  RxString businessName = "".obs;
  RxInt homeIndex = 0.obs;
  RxBool isTaxable = false.obs;
  RxBool isDark = false.obs;
  

  

  void changeTheme(bool value){
    isDark.value = value;
  }
  

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
