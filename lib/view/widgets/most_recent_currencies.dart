import 'package:flutter/material.dart';
import 'package:quick_invoice/model/currency.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/view/widgets/currency_button.dart';

class MostRecentCurrencies extends StatelessWidget {
  const MostRecentCurrencies({super.key, required this.currency});
  final CountryCurrency currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppConstant.getWidth(context) * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Most Use Currencies",
            style: TextStyle(color: Colors.black87, fontSize: 15),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 5,
          ),
          CurrencyButton(
            currency: currency,
            isMain: true,
          )
        ],
      ),
    );
  }
}
