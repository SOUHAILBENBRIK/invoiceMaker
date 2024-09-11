import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/view/widgets/main_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late TextEditingController name;

  @override
  void initState() {
    name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  final MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppConstant.getHeight(context),
        width: AppConstant.getWidth(context),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppConstant.getHeight(context) * 0.05,
            ),
            Text(
              "What's your \n business name ?",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.035,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: AppConstant.getWidth(context) * 0.9,
              child: TextField(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                textInputAction: TextInputAction.done,
                cursorColor: Colors.black,
                controller: name,
                onChanged: (value) {
                  mainController.onChange(value);
                  print(mainController.businessName.value);
                },
                decoration: const InputDecoration(
                  labelText: 'Business Name',
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                width: AppConstant.getWidth(context) * 0.8,
                child: Text(
                  "Or use your own name instead ! you can change it later.in Settings",
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            const Spacer(),
            Obx(
              () => Visibility(
                  visible: mainController.businessName.value.isNotEmpty,
                  child: MainButton(
                      title: "Continue",
                      onPressed: () {
                        Get.offAllNamed(AppRoute.homeScreen);
                      },
                      bg: Colors.black,
                      textColor: Colors.white)),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
