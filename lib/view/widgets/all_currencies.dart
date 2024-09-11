import 'package:flutter/material.dart';
import 'package:quick_invoice/model/currency.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/view/widgets/currency_button.dart';

class AllCurrencies extends StatelessWidget {
  const AllCurrencies({super.key, required this.currencies});
  final List<CountryCurrency> currencies;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppConstant.getWidth(context) * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              "All currencies",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ...currencies.map((value) {
            return CurrencyButton(currency: value);
          })
        ],
      ),
    );
  }
}
