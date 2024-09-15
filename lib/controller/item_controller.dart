import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quick_invoice/model/item.dart';

class ItemController extends GetxController {
  RxBool isTaxable = false.obs;
  Rx<ItemModel?> currentItem = Rx<ItemModel?>(null);


  void changeIsTaxible() {
    isTaxable.value = !isTaxable.value;
  }

  void onChangeCurrentItem(ItemModel val) {
  currentItem.value = val;
}
}
