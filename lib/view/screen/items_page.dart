import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Items',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.newItemScreen);
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Get.toNamed(AppRoute.newItemScreen);
          },
        ),
        body: SizedBox(
          width: AppConstant.getWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_document,
                size: 40,
               
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Start by adding a item",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!),
              
            ],
          ),
        ));
  }
}
