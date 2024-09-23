import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/item_controller.dart';
import 'package:quick_invoice/model/item.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/main_button.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final ItemController itemController = Get.find<ItemController>();
  late TextEditingController itemName;
  late TextEditingController itemPrice;
  late TextEditingController itemNotes;
  @override
  void initState() {
    super.initState();
    itemName = TextEditingController();
    itemPrice = TextEditingController();
    itemNotes = TextEditingController();
  }

  @override
  void dispose() {
    itemName.dispose();
    itemPrice.dispose();
    itemNotes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Item", style: Theme.of(context).textTheme.bodyLarge),
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
              const Spacer(flex: 4),
              AnimatedPadding(
                duration: const Duration(milliseconds: 10),
                padding: EdgeInsets.only(
                  bottom: isKeyboardVisible
                      ? MediaQuery.of(context).viewInsets.bottom
                      : AppConstant.getHeight(context) * 0.02,
                ),
                child: MainButton(
                  title: "Save item",
                  onPressed: () async{
                    String id = AppConstant.generateRandomId(10);
                    ItemModel item = ItemModel(
                        id: id,
                        name: itemName.text,
                        notes: itemNotes.text,
                        price: double.tryParse(itemPrice.text) ?? 0.0,
                        isTaxable: itemController.isTaxable.value);

                    await BusinessController().addItem("item", id, item.toMap());
                    Get.offNamed(AppRoute.itemsScreen, arguments: {
                          "state": 1,
                        });
                    
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
          Obx(() {
            return GestureDetector(
              onTap: () {
                itemController.changeIsTaxible();
              },
              child: Container(
                width: AppConstant.getWidth(context) * 0.25,
                decoration: BoxDecoration(
                    color: itemController.isTaxable.value
                        ? AppTheme.lightAccent
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: itemController.isTaxable.value,
                      replacement: const Icon(Icons.add, color: Colors.black),
                      child: const Icon(Icons.check, color: Colors.white),
                    ),
                    Text(
                      "Taxable",
                      style: TextStyle(
                        color: itemController.isTaxable.value == false
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
}
