import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/currency.dart';
import 'package:quick_invoice/utils/constants_app.dart';

class CurrencyButton extends StatelessWidget {
  const CurrencyButton(
      {super.key, this.isMain = false, required this.currency});
  final bool isMain;
  final CountryCurrency currency;

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    return GestureDetector(
      onTap: () {
        mainController.onChangeCurrentCountryCurrency(currency);
        mainController.resetSearch();
        Get.back();
      },
      child: Visibility(
          visible: !isMain,
          replacement: Container(
            width: AppConstant.getWidth(context),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              children: [
                Text(currency.abbreviation,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 20,
                ),
                const Spacer(),
                Text(
                  "${currency.country} ${currency.currency}",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
            width: AppConstant.getWidth(context),
            decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Border color
                    width: 1, // Border width
                  ),
                )),
            child: Row(
              children: [
                Text(currency.abbreviation,
                    style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                Text("${currency.country} ${currency.currency}",
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          )),
    );
  }
}
