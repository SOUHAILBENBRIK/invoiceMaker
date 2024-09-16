import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quick_invoice/model/client.dart';
import 'package:quick_invoice/model/invoice.dart';
import 'package:quick_invoice/model/item.dart';

class InvoiceController extends GetxController {
  Rx<ClientModel?> currentClient = Rx<ClientModel?>(null);
  RxList<ItemInvoice> items = <ItemInvoice>[].obs;
  

  RxBool isTaxable = false.obs;
  Rx<ItemModel?> currentItem = Rx<ItemModel?>(null);


  void changeIsTaxible() {
    isTaxable.value = !isTaxable.value;
  }

  void onChangeCurrentClient(ClientModel val) {
    currentClient.value = val;
  }
  void onChangeCurrentItem(ItemModel val) {
  currentItem.value = val;
}

  void onAddItems(ItemInvoice val) {
    items.value.add(val);
  }
}
