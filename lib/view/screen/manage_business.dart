import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';

class ManageBusinessScreen extends StatefulWidget {
  const ManageBusinessScreen({super.key});

  @override
  State<ManageBusinessScreen> createState() => _ManageBusinessScreenState();
}

class _ManageBusinessScreenState extends State<ManageBusinessScreen> {
  late TextEditingController controller;
  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController address;
  final ImagePicker picker = ImagePicker();
  File? image;
  final MainController mainController = Get.find();
  @override
  void initState() {
    controller = TextEditingController(text: mainController.businessName.value);
    name = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    name.dispose();
    phone.dispose();
    email.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.close),
        ),
        title: Text(
          "Business Info",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: AppConstant.getHeight(context),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              logoWidget(context, text: "Information"),
              inputWidget(context,
                  controller: controller, labelText: "Business name"),
              businessContacts(context,
                  name: "Business contacts",
                  nameController: name,
                  addressController: address,
                  emailController: email,
                  phoneController: phone)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  logoWidget(BuildContext context, {required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 8, bottom: 5),
            child: Text(text,
                style: TextStyle(fontSize: 15, color: Colors.grey[800]))),
        GestureDetector(
          onTap: () async {
            _pickImage(ImageSource.gallery);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10),
            width: AppConstant.getWidth(context) * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                image != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          image!,
                          height: AppConstant.getHeight(context) * 0.1,
                        ),
                      )
                    : const Icon(
                        Icons.photo_size_select_actual_rounded,
                        size: 30,
                      ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: image != null,
                  replacement: const Text("Add logo",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                  child: const Text("Tap to change",
                      style: TextStyle(color: Colors.grey, fontSize: 14)),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  inputWidget(BuildContext context,
      {required TextEditingController controller, required String labelText}) {
    return Container(
      width: AppConstant.getWidth(context) * 0.9,
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      decoration: BoxDecoration(
          color: AppTheme.lightSecondary,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: TextField(
          cursorColor: Colors.black,
          controller: controller,
          style: const TextStyle(color: Colors.black, fontSize: 14),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              enabledBorder: InputBorder.none,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              hintText: labelText,
              hintStyle: const TextStyle(color: Colors.black87, fontSize: 16)),
        ),
      ),
    );
  }

  businessContacts(BuildContext context,
      {required String name,
      required TextEditingController nameController,
      required TextEditingController phoneController,
      required TextEditingController emailController,
      required TextEditingController addressController}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3,),
          Container(
              margin: const EdgeInsets.only(left: 5, bottom: 15),
              child: Text(name,
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]))),
          Container(
            decoration: BoxDecoration(
                color: AppTheme.lightSecondary, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                inputC(context, controller: nameController, label: "Your name"),
                inputC(context, controller: phoneController, label: "Phone"),
                inputC(context, controller: emailController, label: "E-mail"),
                inputC(context, controller: addressController, label: "Address"),
                SizedBox(height: 3,),
              ],
            ),
          )
        ],
      ),
    );
  }

  inputC(BuildContext context,
      {required TextEditingController controller, required String label}) {
    return Container(
      width: AppConstant.getWidth(context) * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: TextField(
        cursorColor: Colors.black,
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            hintText: label,
            hintStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black)),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[50]!))),
      ),
    );
  }
}
