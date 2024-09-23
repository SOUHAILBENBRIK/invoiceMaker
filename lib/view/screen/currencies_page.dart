import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/currency.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/currency_list.dart';
import 'package:quick_invoice/view/widgets/all_currencies.dart';
import 'package:quick_invoice/view/widgets/search_widget.dart';

class CurrenciesPage extends StatefulWidget {
  const CurrenciesPage({super.key});

  @override
  State<CurrenciesPage> createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {
  List<CountryCurrency> countryCurrencyList = [];
  late TextEditingController controller;
  final MainController mainController = Get.find<MainController>();
  @override
  void initState() {
    _loadItems();
    controller = TextEditingController();
    super.initState();
  }

  Future<void> _loadItems() async {
    Future.delayed(Duration.zero, () {
      countryCurrencyList =
          currencyList.map((json) => CountryCurrency.fromJson(json)).toList();
      mainController.currencies(countryCurrencyList);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              const SizedBox(
                height: 5,
              ),
              SearchWidget(controller: controller),
              SizedBox(
                height: AppConstant.getHeight(context) * .02,
              ),
              const AllCurrencies()
            ],
          ),
        ),
      ),
    );
  }
}
