import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/estimate_controller.dart';
import 'package:quick_invoice/controller/invoice_controller.dart';
import 'package:quick_invoice/model/invoice.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/main_button.dart';

class AddItemInvoicePage extends StatefulWidget {
  const AddItemInvoicePage({super.key});

  @override
  State<AddItemInvoicePage> createState() => _AddItemInvoicePageState();
}

class _AddItemInvoicePageState extends State<AddItemInvoicePage> {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final EstimateController estimateController = Get.find<EstimateController>();
  late TextEditingController itemName;
  late TextEditingController itemPrice;
  late TextEditingController itemNotes;
  late TextEditingController itemQuantity;
  @override
  void initState() {
    super.initState();
    itemName = TextEditingController();
    itemPrice = TextEditingController();
    itemNotes = TextEditingController();
    itemQuantity = TextEditingController();
    var arguments = Get.arguments;
    int state = arguments['state'] as int;
    if (state == 1) {
      Future.delayed(Duration.zero, () {
        itemName.text = invoiceController.currentItem.value?.name ?? "";
        itemPrice.text =
            invoiceController.currentItem.value?.price.toString() ?? "";
        itemNotes.text = invoiceController.currentItem.value?.notes ?? "";
        itemQuantity.text = "1";
      });
    } else {
      Future.delayed(Duration.zero, () {
        itemName.text = estimateController.currentItem.value?.name ?? "";
        itemPrice.text =
            estimateController.currentItem.value?.price.toString() ?? "";
        itemNotes.text = estimateController.currentItem.value?.notes ?? "";
        itemQuantity.text = "1";
      });
    }
  }

  @override
  void dispose() {
    itemName.dispose();
    itemPrice.dispose();
    itemNotes.dispose();
    itemQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Item", style: Theme.of(context).textTheme.bodyLarge),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: AppConstant.getWidth(context),
          height: AppConstant.getHeight(context),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              part2(context),
              SizedBox(height: AppConstant.getHeight(context) * 0.02),
              part1(context),
              SizedBox(
                height: AppConstant.getHeight(context) * 0.02,
              ),
              deleteItem(context),
              const Spacer(flex: 4),
              AnimatedPadding(
                duration: const Duration(milliseconds: 10),
                padding: EdgeInsets.only(
                  bottom: isKeyboardVisible
                      ? MediaQuery.of(context).viewInsets.bottom
                      : AppConstant.getHeight(context) * 0.02,
                ),
                child: MainButton(
                  title: "Add item",
                  onPressed: () async {
                    var arguments = Get.arguments;
                    int state = arguments['state'];
                    String id = AppConstant.generateRandomId(10);
                    
                    if (state == 1) {
                      ItemInvoice item = ItemInvoice(
                        id: id,
                        name: itemName.text,
                        notes: itemNotes.text,
                        price: double.tryParse(itemPrice.text) ?? 0.0,
                        isTaxable: invoiceController.isTaxable.value,
                        discount: 10,
                        count: int.tryParse(itemQuantity.text) ?? 0);
                      invoiceController.changeTotal(
                          number: item.count, price: item.price);
                      invoiceController.onAddItems(item);
                      Get.offAllNamed(AppRoute.newInvoiceScreen);
                    } else {
                      ItemInvoice item = ItemInvoice(
                        id: id,
                        name: itemName.text,
                        notes: itemNotes.text,
                        price: double.tryParse(itemPrice.text) ?? 0.0,
                        isTaxable: estimateController.isTaxable.value,
                        discount: 10,
                        count: int.tryParse(itemQuantity.text) ?? 0);
                      estimateController.changeTotal(
                          number: item.count, price: item.price);
                      estimateController.onAddItems(item);
                      Get.offAllNamed(AppRoute.newEstimateScreen);
                    }
                  },
                  bg: Colors.black,
                  textColor: Colors.white,
                ),
              ),
              Visibility(
                visible: isKeyboardVisible,
                child: SizedBox(height: AppConstant.getHeight(context) * 0.08),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Container part2(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppConstant.getHeight(context) * 0.015, horizontal: 2),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: AppTheme.lightSecondary,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          input(context,
              controller: itemName, text: "item or service provided"),
          SizedBox(
            height: AppConstant.getHeight(context) * 0.015,
          ),
          input(context, controller: itemNotes, text: "Notes (optional)"),
        ],
      ),
    );
  }

  Container input(BuildContext context,
      {required TextEditingController controller, required String text}) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: AppConstant.getWidth(context) * 0.9,
      child: TextField(
        style: const TextStyle(color: Colors.black, fontSize: 14),
        textInputAction: TextInputAction.done,
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
        ),
      ),
    );
  }

  Container part1(BuildContext context) {
    return Container(
      width: AppConstant.getWidth(context),
      padding: EdgeInsets.symmetric(
          vertical: AppConstant.getHeight(context) * 0.01, horizontal: 6),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: AppTheme.lightSecondary,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: AppConstant.getWidth(context) * 0.9,
            child: TextField(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              controller: itemPrice,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: AppConstant.getWidth(context) * 0.9,
            child: TextField(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              controller: itemQuantity,
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
            ),
          ),
          Obx(() {
            return GestureDetector(
              onTap: () {
                invoiceController.changeIsTaxible();
              },
              child: Container(
                width: AppConstant.getWidth(context) * 0.25,
                decoration: BoxDecoration(
                    color: invoiceController.isTaxable.value
                        ? AppTheme.lightAccent
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: invoiceController.isTaxable.value,
                      replacement: const Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                      child: const Icon(Icons.check, color: Colors.grey),
                    ),
                    Text(
                      "Taxable",
                      style: TextStyle(
                        color: invoiceController.isTaxable.value == false
                            ? Colors.black
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  deleteItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BusinessController()
            .deleteItem('item', invoiceController.currentItem.value!.id);
        Get.offAllNamed(AppRoute.itemsScreen);
      },
      child: SizedBox(
        width: AppConstant.getWidth(context) * 0.9,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Delete item",
              style: TextStyle(color: Colors.red, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
