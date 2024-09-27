import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quick_invoice/model/invoice.dart';
import 'package:quick_invoice/model/item.dart';

class EstimateController extends GetxController {
  RxList<ItemInvoice> items = <ItemInvoice>[].obs;
  
  Rx<DateTime?> issuedDate = Rx<DateTime?>(null);
  RxDouble total = 0.0.obs;
  RxInt discount = 0.obs;
  RxString estimateName = "ES001".obs;

  RxBool isTaxable = false.obs;
  Rx<ItemModel?> currentItem = Rx<ItemModel?>(null);

  void changeIsTaxible() {
    isTaxable.value = !isTaxable.value;
  }

  void changeEstimateName(String val) {
    estimateName.value = val;
  }

  void clearTotla() {
    total.value = 0.0;
  }

  void changeTotal({required int number, required double price}) {
    total.value = total.value + number * price;
    total.value = total.value - (discount / 100) * total.value;
  }

  void changeDiscount(int value) {
    discount.value = value;
    total.value = total.value - discount / 100 * total.value;
  }

 

  void addIssuedDate(DateTime val) {
    issuedDate.value = val;
  }

  void restForm() {
    items.clear();
    total.value = 0;
    discount.value = 0; 
    currentItem.value = null;
    issuedDate.value = null;
  }

  void onChangeCurrentItem(ItemModel val) {
    currentItem.value = val;
  }

  void onAddItems(ItemInvoice val) {
    items.add(val);
  }

  void onDeleteItems(ItemInvoice val) {
    items.remove(val);
  }
}
