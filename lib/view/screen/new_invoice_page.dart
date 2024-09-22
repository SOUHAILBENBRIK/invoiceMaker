import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/invoice_controller.dart';
import 'package:quick_invoice/model/invoice.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/bottom_widget.dart';
import 'package:quick_invoice/view/widgets/main_button.dart';
import 'package:quick_invoice/view/widgets/new_button_widget.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  @override
  void initState() {
    final invoice = BusinessController().getAllItems("invoice");
    invoiceController.changeInvoiceName("0" + invoice.length.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoute.homeScreen);
            invoiceController.restForm();
          },
          child: const Icon(Icons.close),
        ),
      ),
      body: Container(
        width: AppConstant.getHeight(context),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            Text("New Invoice", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.02,
            ),
            Obx(() {
              return Visibility(
                visible: invoiceController.items.isNotEmpty &&
                    invoiceController.currentClient.value != null,
                child: _topPart(context, controller: invoiceController),
              );
            }),
            Obx(() {
              return Visibility(
                visible: invoiceController.currentClient.value == null,
                replacement:
                    checkedName(context, mainController: invoiceController),
                child: NewButtonWidget(
                    title: "Client",
                    onPressed: () => Get.toNamed(AppRoute.clientScreen,
                        arguments: {"invoice": true}),
                    icon: Icons.person_add),
              );
            }),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.02,
            ),
            Obx(() {
              return Visibility(
                visible: invoiceController.items.isEmpty,
                replacement:
                    _listOfItem(context, controller: invoiceController),
                child: NewButtonWidget(
                    title: "Item",
                    onPressed: () =>
                        Get.toNamed(AppRoute.itemsScreen, arguments: {
                          "invoice": true,
                        }),
                    icon: Icons.format_list_bulleted_add),
              );
            }),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.035,
            ),
            discount(context, invoiceController),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.01,
            ),
            total(context, invoiceController),
            const Spacer(),
            const Text(
              "Best solution to creating invoices",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.01,
            ),
            Visibility(
                visible: invoiceController.currentClient.value != null &&
                    invoiceController.items.isNotEmpty &&
                    invoiceController.duoDate.value != null,
                child: MainButton(
                    title: "Add invoice",
                    onPressed: () {},
                    bg: Colors.black,
                    textColor: Colors.white)),
            SizedBox(
              height: AppConstant.getHeight(context) * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  Container total(BuildContext context, InvoiceController invoiceController) {
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
            GestureDetector(
              onTap: () => Get.toNamed(AppRoute.currenciesScreen),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    Text(
                      "TND",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Obx(() {
              return Text(
                "${invoiceController.total.value}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              );
            }),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }

  Widget checkedName(BuildContext context,
      {required InvoiceController mainController}) {
    var client = mainController.currentClient.value;
    return Container(
      width: AppConstant.getWidth(context) * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.lightSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(client?.name ?? ""),
          const Spacer(),
          Text(client?.email ?? ""),
        ],
      ),
    );
  }

  _listOfItem(BuildContext context, {required InvoiceController controller}) {
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
                          width: AppConstant.getWidth(context) * 0.2,
                          child: Row(
                            children: [
                              Text(item.price.toString()),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    controller.onDeleteItems(item);
                                    controller.changeTotal(
                                        number: item.count,
                                        price: item.price * -1);
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
                "invoice": true,
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

  _topPart(BuildContext context, {required InvoiceController controller}) {
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
              text: invoiceController.invoiceName.value, icon: Icons.inventory_outlined),
        ],
      ),
    );
  }

  _iconButton(BuildContext context, InvoiceController controller,
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

  discount(BuildContext context, InvoiceController invoiceController) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(DiscountPage());
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
                  "${invoiceController.discount.value}%",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
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
