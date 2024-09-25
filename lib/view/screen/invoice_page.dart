import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';

import 'package:quick_invoice/controller/main_controller.dart';

import 'package:quick_invoice/model/business.dart';
import 'package:quick_invoice/model/invoice.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/pdf_invoice_widget.dart';
import 'package:quick_invoice/view/widgets/search_widget.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late TextEditingController searchController;
  List list = [];
  Business? business;
  final MainController mainController = Get.find<MainController>();
  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
    _loadInvoices();
    business = Business.fromMap(Map<String, dynamic>.from(
        BusinessController().getItem("business", "me")));
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> _loadInvoices() async {
    Future.delayed(Duration.zero, () {
      final invoices = BusinessController().getAllItems("invoice");
      mainController.changeInvoices(
        invoices.map((invoice) {
          return InvoiceModel.fromMap(Map<String, dynamic>.from(invoice));
        }).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: AppConstant.getHeight(context),
          width: AppConstant.getWidth(context),
          child: Obx(() {
            return Visibility(
              visible: mainController.invoices.isNotEmpty,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_document,
                      size: AppConstant.getWidth(context) * 0.15,
                      color: Colors.grey),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Start by Creating new Invoice",
                      style: Theme.of(context).textTheme.bodyMedium!),
                ],
              ),
              child: _listInvoice(context),
            );
          })),
    );
  }

  Widget _listInvoice(BuildContext context) {
    return SizedBox(
      width: AppConstant.getWidth(context),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SearchWidget(controller: searchController),
          const SizedBox(
            height: 15,
          ),
          Visibility(
            visible: mainController.filteredInvoice.isNotEmpty,
            replacement: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  const Icon(
                    Icons.edit_document,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Start by Creating new Invoice",
                      style: Theme.of(context).textTheme.bodyMedium!),
                  const Spacer(),
                ],
              ),
            ),
            child: Expanded(
              child: ListView.builder(
                  itemCount: mainController.filteredInvoice.length,
                  itemBuilder: (context, index) {
                    final InvoiceModel item =
                        mainController.filteredInvoice[index];
                    return GestureDetector(
                      onTap: () async {
                        final InvoicePdfGenerator _pdfGenerator =
                            InvoicePdfGenerator(
                          company: business!,
                          invoice: item,
                        );
                        await _pdfGenerator.generateInvoicePdf();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invoice PDF generated!')),
                        );
                      },
                      child: Container(
                        width: AppConstant.getWidth(context) * 0.9,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppTheme.lightSecondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Name : ${item.invoiceNumber}"),
                                const Spacer(),
                                Text("Total : ${item.total}"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("ClientName : ${item.clientName.name}"),
                                const Spacer(),
                                Text(item.invoiceDate.split("T")[0])
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
