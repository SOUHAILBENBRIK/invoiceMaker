import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/invoice_controller.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/view/widgets/main_button.dart';
import 'package:quick_invoice/view/widgets/message_widget.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  late TextEditingController discount;
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  @override
  void initState() {
    super.initState();
    discount = TextEditingController(text: invoiceController.discount.toString());
  }

  @override
  void dispose() {
    super.dispose();
    discount.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      height: AppConstant.getHeight(context) * 0.4,
      width: AppConstant.getWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          const Spacer(),
          Text('Add Discount',style: Theme.of(context).textTheme.bodyLarge,),
          const Spacer(),
          input(context,
              controller: discount,
              text: "enter discount in percentage from 0 to 100",),
          const Spacer(),
          MainButton(
              title: "add Discount",
              onPressed: () {
                int value = int.tryParse(discount.text) ?? 0;
                if (value <= 100 && value >= 0) {
                  invoiceController.changeDiscount(value);
                  Get.back();
                } else {
                  MessageWidget.failMessage(
                      title: "enter number between 0% and 100%");
                  discount.clear();
                }
              },
              bg: Colors.black,
              textColor: Colors.white),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Container input(BuildContext context,
      {required TextEditingController controller,
      required String text,
     }) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: AppConstant.getWidth(context) * 0.9,
      child: TextField(
        style: const TextStyle(color: Colors.black, fontSize: 14),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
        ),
      ),
    );
  }
}
