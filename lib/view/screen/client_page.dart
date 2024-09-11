import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({super.key});

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
            'Clients',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.newClientScreen);
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
            Get.toNamed(AppRoute.newClientScreen);
          },
        ),
        body: SizedBox(
          width: AppConstant.getWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person_add,
                size: 40
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Start by adding a client",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ),
              
            ],
          ),
        ));
  }
}
