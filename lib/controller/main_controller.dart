import 'package:get/get.dart';
import 'package:quick_invoice/model/business.dart';
import 'package:quick_invoice/model/client.dart';
import 'package:quick_invoice/model/item.dart';

class MainController extends GetxController {
  RxString businessName = "".obs;
  RxInt homeIndex = 0.obs;
  
  RxBool isDark = false.obs;
  RxList<ItemModel> items = <ItemModel>[].obs;
  RxList<ClientModel> clients = <ClientModel>[].obs;
  final searchTerm = ''.obs;
  List<T> filterList<T>(List<T> list, String Function(T) getName) {
    if (searchTerm.isEmpty) {
      return list;
    } else {
      return list.where((item) => getName(item).toLowerCase().contains(searchTerm.value.toLowerCase())).toList();
    }
  }
  List<ItemModel> get filteredItems {
    return filterList(items, (item) => item.name);
  }
  List<ClientModel> get filteredClient {
    return filterList(clients, (client) => client.name);
  }

  void updateSearchTerm(String term) {
    searchTerm.value = term;
  }

  RxList invoices = [].obs;
  RxList estimes = [].obs;
   
  //Rx<InvoiceModel?> currentInvoice = null.obs;
  Rx<Business?> currentBusniss = null.obs;
  
  



  void changeBusniness(Business val){
    currentBusniss.value = val;
  }
  void changeItems(List<ItemModel> val){
    items.value = val;
  }
  void changeClient(List<ClientModel> val){
    clients.value = val;
  }
  void changeTheme(bool value) {
    isDark.value = value;
  }

  

  void onChange(String value) {
    businessName.value = value;
  }

  void onChnageIndex(int value) {
    homeIndex.value = value;
  }
}
