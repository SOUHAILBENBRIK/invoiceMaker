import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/estimate_controller.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/estimate.dart';
import 'package:quick_invoice/model/invoice.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/bottom_widget.dart';
import 'package:quick_invoice/view/widgets/main_button.dart';
import 'package:quick_invoice/view/widgets/new_button_widget.dart';

class NewEstimateScreen extends StatefulWidget {
  const NewEstimateScreen({super.key});

  @override
  State<NewEstimateScreen> createState() => _NewEstimateScreenState();
}

class _NewEstimateScreenState extends State<NewEstimateScreen> {
  final EstimateController estimateController = Get.find<EstimateController>();
  final MainController mainController = Get.find<MainController>();
  @override
  void initState() {
    final estimates = BusinessController().getAllItems("estimate");
    estimateController.changeEstimateName("E0${estimates.length + 1}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.homeScreen);
            estimateController.restForm();
          },
          child: const Icon(Icons.close),
        ),
      ),
      body: Container(
        width: AppConstant.getHeight(context),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Text("New Estimate", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.02,
            ),
            Obx(() {
              return Visibility(
                visible: estimateController.items.isNotEmpty ,
                child: _topPart(context, controller: estimateController),
              );
            }),
           
            SizedBox(
              height: AppConstant.getHeight(context) * 0.02,
            ),
            Obx(() {
              return Visibility(
                visible: estimateController.items.isEmpty,
                replacement:
                    _listOfItem(context, controller: estimateController),
                child: NewButtonWidget(
                    title: "Item",
                    onPressed: () =>
                        Get.toNamed(AppRoute.itemsScreen, arguments: {
                          "state": 2,// new estimate
                        }),
                    icon: Icons.format_list_bulleted_add),
              );
            }),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.035,
            ),
            discount(context, estimateController),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.01,
            ),
            total(context, estimateController),
            const Spacer(),
            const Text(
              "Best solution to creating invoices",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.01,
            ),
            Obx(() {
              return Visibility(
                  visible:
                      estimateController.items.isNotEmpty &&
                      estimateController.duoDate.value != null &&
                      mainController.currentCountryCurrency .value != null,
                  child: MainButton(
                      title: "Add estimate",
                      onPressed: () async {
                        String id = AppConstant.generateRandomId(10);
                        EstimateModel estimate = EstimateModel(
                            id: id,
                            currency: mainController.currentCountryCurrency.value!,
                            estimateNumber: estimateController.estimateName.value,
                            discount: estimateController.discount.value,
                            estimateDate: estimateController.issuedDate.value
                                    ?.toIso8601String() ??
                                "",
                            estimateDue: estimateController.duoDate.value
                                    ?.toIso8601String() ??
                                "",
                            total: estimateController.total.value,
                            note: "",
                            items: estimateController.items);

                        await BusinessController()
                            .addItem("estimate", id, estimate.toMap());
                        Get.offNamed(AppRoute.homeScreen);
                      },
                      bg: Colors.black,
                      textColor: Colors.white));
            }),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  Container total(BuildContext context, EstimateController estimateController) {
    return Container(
        width: AppConstant.getWidth(context) * 0.9,
        height: AppConstant.getHeight(context) * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            const Text("Total",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            const Spacer(),
            _currencyWidget(),
            const SizedBox(
              width: 10,
            ),
            Obx(() {
              return Text(
                "${estimateController.total.value}",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              );
            }),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }

  GestureDetector _currencyWidget() {
    return GestureDetector(
            onTap: () => Get.toNamed(AppRoute.currenciesScreen,arguments : {
              'state':2
            }),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child:  Row(
                children: [
                  Obx(
                    () {
                      return Text(
                        mainController.currentCountryCurrency.value!.abbreviation,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      );
                    }
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          );
  }

 

  _listOfItem(BuildContext context, {required EstimateController controller}) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: AppConstant.getWidth(context) * 0.9,
            height: AppConstant.getHeight(context) * 0.3,
            decoration: BoxDecoration(
                color: AppTheme.lightSecondary,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  ItemInvoice item = controller.items[index];
                  return Container(
                    width: AppConstant.getWidth(context) * 0.9,
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Colors.black),
                    )),
                    child: ListTile(
                        title: Text(
                          item.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: SizedBox(
                          width: AppConstant.getWidth(context) * 0.5,
                          child: Row(
                            children: [
                              const Spacer(),
                              Text(
                                item.price.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.onDeleteItems(item);
                                    controller.clearTotla();
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ))
                            ],
                          ),
                        ),
                        subtitle: Text(
                          item.count.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                  );
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.itemsScreen, arguments: {
                "state": 2, // new estimate
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.topLeft,
              width: AppConstant.getWidth(context) * 0.4,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(child: Text("Add new item")),
            ),
          )
        ],
      ),
    );
  }

  _topPart(BuildContext context, {required EstimateController controller}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppConstant.getWidth(context),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final today = DateTime.now();
              final date = await showDatePickerDialog(
                context: context,
                initialDate: DateTime(today.year, today.month, today.day),
                minDate: DateTime(2020, 1, 1),
                maxDate: DateTime(today.year + 2, today.month, today.day),
                width: AppConstant.getWidth(context) * 0.9,
                height: AppConstant.getHeight(context) * 0.4,
                currentDate: DateTime(today.year, today.month, today.day),
                selectedDate: DateTime(today.year, today.month, today.day),
                currentDateDecoration: const BoxDecoration(),
                currentDateTextStyle: const TextStyle(),
                daysOfTheWeekTextStyle: const TextStyle(),
                disabledCellsTextStyle: const TextStyle(),
                enabledCellsDecoration: const BoxDecoration(),
                enabledCellsTextStyle: const TextStyle(),
                initialPickerType: PickerType.days,
                selectedCellDecoration: const BoxDecoration(),
                selectedCellTextStyle: const TextStyle(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: Colors.black,
                highlightColor: Colors.black.withOpacity(0.3),
                slidersSize: 20,
                splashColor: Colors.black.withOpacity(0.3),
                splashRadius: 40,
                centerLeadingDate: true,
              );
              if (date != null) {
                controller.addDuoDate(date);
              }
            },
            child: _iconButton(context, controller,
                text: "No duo date",
                icon: Icons.date_range,
                date: controller.duoDate.value),
          ),
          GestureDetector(
            onTap: () async {
              final today = DateTime.now();
              final date = await showDatePickerDialog(
                context: context,
                initialDate: DateTime(today.year, today.month, today.day),
                minDate: DateTime(2020, 1, 1),
                maxDate: DateTime(today.year + 2, today.month, today.day),
                width: AppConstant.getWidth(context) * 0.9,
                height: AppConstant.getHeight(context) * 0.4,
                currentDate: DateTime(today.year, today.month, today.day),
                selectedDate: DateTime(today.year, today.month, today.day),
                currentDateDecoration: const BoxDecoration(),
                currentDateTextStyle: const TextStyle(),
                daysOfTheWeekTextStyle: const TextStyle(),
                disabledCellsTextStyle: const TextStyle(),
                enabledCellsDecoration: const BoxDecoration(),
                enabledCellsTextStyle: const TextStyle(),
                initialPickerType: PickerType.days,
                selectedCellDecoration: const BoxDecoration(),
                selectedCellTextStyle: const TextStyle(),
                leadingDateTextStyle: const TextStyle(),
                slidersColor: Colors.black,
                highlightColor: Colors.black.withOpacity(0.3),
                slidersSize: 20,
                splashColor: Colors.black.withOpacity(0.3),
                splashRadius: 40,
                centerLeadingDate: true,
              );
              if (date != null) {
                controller.addIssuedDate(date);
              }
            },
            child: _iconButton(context, controller,
                text: "Issued date",
                icon: Icons.date_range,
                date: controller.issuedDate.value),
          ),
          _iconButton(context, controller,
              text: estimateController.estimateName.value,
              icon: Icons.inventory_outlined),
        ],
      ),
    );
  }

  _iconButton(BuildContext context, EstimateController controller,
      {required String text,
      required IconData icon,
      DateTime? date,
      String? textCase}) {
    return Container(
      width: AppConstant.getWidth(context) * 0.3,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          const SizedBox(
            width: 5,
          ),
          Visibility(
            visible: date != null,
            child: Text(
              "${date?.month}/${date?.day}/${date?.year}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Visibility(
            visible: textCase != null,
            child: Text(
              textCase ?? "",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Visibility(
              visible: textCase == null && date == null,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              ))
        ],
      ),
    );
  }

  discount(BuildContext context, EstimateController estimateController) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(const DiscountPage());
      },
      child: Container(
          width: AppConstant.getWidth(context) * 0.9,
          height: AppConstant.getHeight(context) * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              const Text("Discount",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              const Spacer(),
              Obx(() {
                return Text(
                  "${estimateController.discount.value}%",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                );
              }),
              const SizedBox(
                width: 20,
              ),
            ],
          )),
    );
  }
}
