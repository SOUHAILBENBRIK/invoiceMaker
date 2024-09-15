import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quick_invoice/model/client.dart';

class ClientController extends GetxController {
  Rx<ClientModel?> currentClient = Rx<ClientModel?>(null);

  void onChangeCurrentClient(ClientModel val) {
  currentClient.value = val;
}
}
