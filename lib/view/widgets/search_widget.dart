import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/utils/constants_app.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, required this.controller});
  final TextEditingController controller;
  
  
  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.put(MainController());
    return SizedBox(
      width: AppConstant.getWidth(context)*0.9,
      child: TextField(
        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14),
        
        controller: controller,
        onChanged: (value) => mainController.updateSearchTerm(value),
        decoration: const InputDecoration(
                labelStyle: TextStyle(fontSize: 15,color: Colors.black),
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
      ),
    );
  }
}
