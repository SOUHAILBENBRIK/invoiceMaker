import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quick_invoice/utils/constants_app.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  late TextEditingController itemName;
  @override
  void initState() {
    super.initState();
    itemName = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    itemName.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
      ),
      height: AppConstant.getHeight(context)*0.2,
      width: AppConstant.getWidth(context),
      color: Colors.white,
      child: Column(
        children: [
          Text('Modal Bottom Sheet'),
          input(context,
              controller: itemName, text: "item or service provided"),
        ],
      ),
    );
  }

   Container input(BuildContext context,
      {required TextEditingController controller, required String text, TextInputType type= TextInputType.text,TextInputAction textAction = TextInputAction.next}) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: AppConstant.getWidth(context) * 0.9,
      child: TextField(
        style: const TextStyle(color: Colors.black, fontSize: 14),
        textInputAction: textAction,
        keyboardType: type,
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
        ),
      ),
    );
  }
}