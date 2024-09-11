import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/model/currency.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/currency_list.dart';
import 'package:quick_invoice/view/widgets/all_currencies.dart';
import 'package:quick_invoice/view/widgets/most_recent_currencies.dart';

class CurrenciesPage extends StatefulWidget {
  const CurrenciesPage({super.key});

  @override
  State<CurrenciesPage> createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {
  List<CountryCurrency> countryCurrencyList = [];
  @override
  void initState() {
    countryCurrencyList =
        currencyList.map((json) => CountryCurrency.fromJson(json)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          "Currency",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SizedBox(
        width: AppConstant.getWidth(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MostRecentCurrencies(
                currency: countryCurrencyList[0],
              ),
              SizedBox(
                height: AppConstant.getHeight(context) * .02,
              ),
              AllCurrencies(currencies: countryCurrencyList)
            ],
          ),
        ),
      ),
    );
  }
}
