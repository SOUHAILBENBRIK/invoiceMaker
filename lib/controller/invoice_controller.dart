import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quick_invoice/model/client.dart';
import 'package:quick_invoice/model/invoice.dart';
import 'package:quick_invoice/model/item.dart';

class InvoiceController extends GetxController {
  Rx<ClientModel?> currentClient = Rx<ClientModel?>(null);
  
  RxList<ItemInvoice> items = <ItemInvoice>[].obs;
  Rx<DateTime?> duoDate = Rx<DateTime?>(null);
  Rx<DateTime?> issuedDate = Rx<DateTime?>(null);
  RxDouble total = 0.0.obs;
  RxInt discount = 0.obs;
  RxString invoiceName = "INV001".obs;

  RxBool isTaxable = false.obs;
  Rx<ItemModel?> currentItem = Rx<ItemModel?>(null);

  void changeIsTaxible() {
    isTaxable.value = !isTaxable.value;
  }

  void changeInvoiceName (String val){
    invoiceName.value = val;
  }
  void clearTotla(){
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

  void addDuoDate(DateTime val) {
    duoDate.value = val;
  }

  void addIssuedDate(DateTime val) {
    issuedDate.value = val;
  }

  void restForm() {
    items.clear();
    currentClient.value = null;
    currentItem.value = null;
    duoDate.value = null;
    issuedDate.value = null;
  }

  void onChangeCurrentClient(ClientModel val) {
    currentClient.value = val;
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
