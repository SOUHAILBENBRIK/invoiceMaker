import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/model/client.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/main_button.dart';

class NewClientScreen extends StatefulWidget {
  const NewClientScreen({super.key});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  late TextEditingController clientName;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController address;
  
  @override
  void initState() {
    super.initState();
    clientName = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
  }

  @override
  void dispose() {
    clientName.dispose();
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
                  title: "Save Client",
                  onPressed: () async {
                    String id = AppConstant.generateRandomId(10);
                  ClientModel client = ClientModel(
                        id: id,
                        name: clientName.text,
                        email: email.text,
                        address: address.text,
                        phone: phone.text);

                    await BusinessController().addItem("client", id, client.toMap());
                    var arguments = Get.arguments;
                        bool invoice = arguments['invoice'] as bool??false;
                    Get.offNamed(AppRoute.clientScreen,arguments: {
                      "invoice":invoice
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
          border: Border.all(color: Colors.grey),
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
              textInputAction: TextInputAction.next,
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
          input(context, controller: phone, text: "Phone",type: TextInputType.phone),
          SizedBox(
            height: AppConstant.getHeight(context) * 0.015,
          ),
          input(context, controller: email, text: "E-mail",type: TextInputType.emailAddress),
          SizedBox(
            height: AppConstant.getHeight(context) * 0.015,
          ),
          input(context, controller: address, text: "Address",textAction: TextInputAction.done),
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
