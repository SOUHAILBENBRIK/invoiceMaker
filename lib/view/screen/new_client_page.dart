import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/view/widgets/main_button.dart';

class NewClientScreen extends StatefulWidget {
  const NewClientScreen({super.key});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  late TextEditingController clientName;
  late TextEditingController phoneNumber;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController address;
  
  @override
  void initState() {
    super.initState();
    clientName = TextEditingController();
    phoneNumber = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
  }

  @override
  void dispose() {
    clientName.dispose();
    phoneNumber.dispose();
    email.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Client", style: Theme.of(context).textTheme.bodyLarge),
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
              SizedBox(height: AppConstant.getHeight(context) * 0.02),
              part2(context),
              const Spacer(flex: 4),
              AnimatedPadding(
                duration: const Duration(milliseconds: 10),
                padding: EdgeInsets.only(
                  bottom: isKeyboardVisible
                      ? MediaQuery.of(context).viewInsets.bottom
                      : AppConstant.getHeight(context) * 0.02,
                ),
                child: MainButton(
                  title: "Continue",
                  onPressed: () {
                    Get.offAllNamed(AppRoute.homeScreen);
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
          border: Border.all(color: Colors.grey),
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
              cursorColor: Colors.black,
              controller: clientName,
              decoration: const InputDecoration(
                labelText: 'Client Name',
              ),
            ),
          ),
          SizedBox(
            height: AppConstant.getHeight(context) * 0.015,
          ),
          input(context, controller: phoneNumber, text: "Phone"),
          SizedBox(
            height: AppConstant.getHeight(context) * 0.015,
          ),
          input(context, controller: email, text: "E-mail"),
          SizedBox(
            height: AppConstant.getHeight(context) * 0.015,
          ),
          input(context, controller: address, text: "Address"),
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
}
