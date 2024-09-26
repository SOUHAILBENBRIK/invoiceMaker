import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/business.dart';
import 'package:quick_invoice/model/icon_parameters.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final MainController mainController = Get.find<MainController>();
  Uint8List? image;

  @override
  void initState() {
    super.initState();
    Business? business = Business.fromMap(Map<String, dynamic>.from(
        BusinessController().getItem("business", "me")));

    image = business.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
        child: const Icon(Icons.close),
        onTap: () => Get.offAllNamed(AppRoute.homeScreen),
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
            SizedBox(
              height: AppConstant.getHeight(context) * 0.01,
            ),
            info(context, list: AppConstant.iconsInfo),
            const Spacer(
              flex: 3,
            ),
            Text("Version 1.0.0",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  titleWidget(BuildContext context, {required String name}) {
    return SizedBox(
      child: Row(
        children: [
          Text(name, style: Theme.of(context).textTheme.headlineSmall),
          const Spacer(),
          Visibility(
            visible: image == null,
            replacement: image != null
                ? CircleAvatar(
                    backgroundImage: Image.memory(image!).image,
                    radius: 20,
                  )
                : const SizedBox(),
            child: Container(
              height: AppConstant.getWidth(context) * 0.12,
              width: AppConstant.getWidth(context) * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.lightAccent.withOpacity(0.6),
              ),
              child: Center(
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
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
          color: AppTheme.lightSecondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ...list.map((val) {
              return buttonParameter(
                context,
                val,
                onTap: () {
                  Get.toNamed(val.path, arguments: {"state": 0});
                },
              );
            })
          ],
        ));
  }

  GestureDetector buttonParameter(BuildContext context, IconParameters val,
      {required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
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
          color: AppTheme.lightSecondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            buttonParameter(context, list[0], onTap: () {
              Uri url = Uri.parse("https://flowcv.me/souhailbenbrik");
              _launchUrl(url);
            }),
            buttonParameter(context, list[1], onTap: () {
              _showDeleteAccountDialog(context);
            }),
          ],
        ));
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Delete Account"),
          content: Text(
              "Are you sure you want to delete your account? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Get.back(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                _deleteAccount();
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    Colors.red, // Change button color to indicate danger
              ),
            ),
          ],
        );
      },
    );
  }

  // Function that contains the account deletion logic
  Future<void> _deleteAccount() async {
    Get.back();
    await BusinessController().clearBox('business');
    await BusinessController().clearBox('invoice');
    await BusinessController().clearBox('client');
   await  BusinessController().clearBox('item');
    await BusinessController().clearBox('estimate');
    Get.offAllNamed(AppRoute.splashScreen);
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
