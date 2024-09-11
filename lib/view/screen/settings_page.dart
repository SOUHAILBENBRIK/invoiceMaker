import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/icon_parameters.dart';
import 'package:quick_invoice/utils/constants_app.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
        child: const Icon(Icons.close),
        onTap: () => Get.back(),
      )),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: AppConstant.getWidth(context),
        child: Column(
          children: [
            titleWidget(context, name: mainController.businessName.value),
            const Spacer(),
            elementWidget(context, list: AppConstant.iconsParameters1),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.01,
            ),
            info(context, list: AppConstant.iconsInfo),
            const Spacer(
              flex: 3,
            ),
            const Text("Version 1.0.0"),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  titleWidget(BuildContext context, {required String name}) {
    return SizedBox(
      child: Row(
        children: [
          Text(name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.black)),
          const Spacer(),
          Container(
            height: AppConstant.getWidth(context) * 0.12,
            width: AppConstant.getWidth(context) * 0.12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppConstant.lightAccent.withOpacity(0.4),
                border: Border.all(color: Colors.black)),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  elementWidget(BuildContext context, {required List<IconParameters> list}) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppConstant.lightSecondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ...list.map((val) {
              return buttonParameter(context, val);
            })
          ],
        ));
  }

  GestureDetector buttonParameter(BuildContext context, IconParameters val) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(val.path);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(val.icon, color: Colors.black, size: 20),
            const SizedBox(
              width: 10,
            ),
            Text(val.name, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      ),
    );
  }

  info(BuildContext context, {required List<IconParameters> list}) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppConstant.lightSecondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ...list.map((val) {
              return buttonParameter(context, val);
            })
          ],
        ));
  }
}
