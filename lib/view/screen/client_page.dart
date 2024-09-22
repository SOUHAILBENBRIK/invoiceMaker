import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/client_controller.dart';
import 'package:quick_invoice/controller/invoice_controller.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/client.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/search_widget.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final MainController mainController = Get.find<MainController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final ClientController clientController = Get.find<ClientController>();
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _loadClients();
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> _loadClients() async {
    Future.delayed(Duration.zero, () {
      final clients = BusinessController().getAllItems("client");
      mainController.changeClient(
        clients.map((client) {
          return ClientModel.fromMap(Map<String, dynamic>.from(client));
        }).toList(),
      );
    });
  }

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
            var arguments = Get.arguments;
            bool invoice = arguments['invoice'] as bool;
            Get.toNamed(AppRoute.newClientScreen,
                arguments: {'invoice': invoice});
          },
        ),
        body: Obx(() {
          return Visibility(
            visible: mainController.clients.isEmpty,
            replacement: itemListWidget(context),
            child: SizedBox(
              width: AppConstant.getWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_add_outlined,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Start by adding an client",
                      style: Theme.of(context).textTheme.bodyMedium!),
                ],
              ),
            ),
          );
        }));
  }

  Widget itemListWidget(BuildContext context) {
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
            visible: mainController.filteredClient.isNotEmpty,
            replacement: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  const Icon(
                    Icons.person_add_outlined,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Start by adding an client",
                      style: Theme.of(context).textTheme.bodyMedium!),
                  const Spacer(),
                ],
              ),
            ),
            child: Expanded(
              child: ListView.builder(
                  itemCount: mainController.filteredClient.length,
                  itemBuilder: (context, index) {
                    final ClientModel client =
                        mainController.filteredClient[index];
                    return GestureDetector(
                      onTap: () {
                        var arguments = Get.arguments;
                        bool invoice = arguments['invoice'] as bool;
                        if (invoice) {
                          invoiceController.onChangeCurrentClient(client);
                          Get.toNamed(AppRoute.newInvoiceScreen);
                        } else {
                          clientController.onChangeCurrentClient(client);
                          Get.toNamed(AppRoute.editClientScreen);
                        }
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
                        child: Row(
                          children: [
                            Text(client.name),
                            const Spacer(),
                            Text(client.email),
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
