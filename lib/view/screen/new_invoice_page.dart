import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/invoice_controller.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/new_button_widget.dart';

class NewInvoiceScreen extends StatelessWidget {
  const NewInvoiceScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
     final InvoiceController invoiceController = Get.find<InvoiceController>();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.close),
        ),
      ),
      body: Container(
        width: AppConstant.getHeight(context),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Text("New Invoice", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.02,
            ),
            Obx(
              () {
                return Visibility(
                  visible: invoiceController.currentClient.value == null,
                  replacement: checkedName(context,mainController: invoiceController),
                  child: NewButtonWidget(
                      title: "Client",
                      onPressed: () => Get.toNamed(AppRoute.clientScreen,arguments:{
                        "invoice":true
                      }),
                      icon: Icons.person_add),
                );
              }
            ),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.02,
            ),
            NewButtonWidget(
                title: "Item",
                onPressed: () => Get.toNamed(AppRoute.itemsScreen),
                icon: Icons.format_list_bulleted_add),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.035,
            ),
            Container(
                width: AppConstant.getWidth(context) * 0.9,
                height: AppConstant.getHeight(context) * 0.07,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Text("Total",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.currenciesScreen),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Row(
                          children: [
                            Text(
                              "TND",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "\$0.00",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )),
            const Spacer(),
            const Text(
              "Choose your Client first",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
    
  }
  Widget checkedName(BuildContext context,{ required InvoiceController mainController}){
    var client =mainController.currentClient.value;
    return Container(
                        width: AppConstant.getWidth(context) * 0.9,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppTheme.lightSecondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(client?.name??""),
                            const Spacer(),
                            Text(client?.email??""),
                          ],
                        ),
                      );
  }
}
