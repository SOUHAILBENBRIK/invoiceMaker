import 'package:flutter/material.dart';
import 'package:quick_invoice/utils/constants_app.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List list = [];
    return Scaffold(
      body: SizedBox(
        height: AppConstant.getHeight(context),
        width: AppConstant.getWidth(context),
        child: Visibility(
          visible: list.isNotEmpty,
          replacement: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit_document,
                  size: AppConstant.getWidth(context) * 0.15,
                  color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Start by Creating new Invoice",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!),
             
            ],
          ),
          child: Text(
            "list is not empty ",
            style: Theme.of(context)
                .textTheme
                .bodyMedium),
          ),
        ),
   
    );
  }
}
