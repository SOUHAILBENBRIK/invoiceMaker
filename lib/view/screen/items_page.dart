import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/estimate_controller.dart';
import 'package:quick_invoice/controller/invoice_controller.dart';
import 'package:quick_invoice/controller/item_controller.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/item.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/search_widget.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  final MainController mainController = Get.find<MainController>();
  final ItemController itemController = Get.find<ItemController>();
  final InvoiceController invoiceController = Get.find<InvoiceController>();
  final EstimateController estimateController = Get.find<EstimateController>();
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _loadItems();
  }

  @override
  dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> _loadItems() async {
    Future.delayed(Duration.zero, () {
      final items = BusinessController().getAllItems("item");
      mainController.changeItems(
        items.map((item) {
          // Ensure proper casting to Map<String, dynamic>
          return ItemModel.fromMap(Map<String, dynamic>.from(item));
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
              var arguments = Get.arguments;
              int state = arguments['state'] as int;
              if (state == 0) {
                Get.offAllNamed(AppRoute.settingsScreen);

              }else if ( state ==1){
                Get.offAllNamed(AppRoute.newInvoiceScreen);
              }
              else{
                Get.offAllNamed(AppRoute.newEstimateScreen);
              }
            },
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Items',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                var arguments = Get.arguments;
                int state = arguments['state'];
                Get.toNamed(AppRoute.newItemScreen,
                    arguments: {'state': state});
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
            int state = arguments['state'];
            print(state);
            Get.toNamed(AppRoute.newItemScreen, arguments: {'state': state});
          },
        ),
        body: Obx(() {
          return Visibility(
            visible: mainController.items.isEmpty,
            replacement: itemListWidget(context),
            child: SizedBox(
              width: AppConstant.getWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit_document,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Start by adding an item",
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
            visible: mainController.filteredItems.isNotEmpty,
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
                  Text("Start by adding an item",
                      style: Theme.of(context).textTheme.bodyMedium!),
                  const Spacer(),
                ],
              ),
            ),
            child: Expanded(
              child: ListView.builder(
                  itemCount: mainController.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = mainController.filteredItems[index];
                    return GestureDetector(
                      onTap: () {
                        var arguments = Get.arguments;
                        int state = arguments['state'] as int;
                        print(state);
                        switch (state) {
                          case 1:
                            invoiceController.onChangeCurrentItem(item);
                            Get.toNamed(AppRoute.addItemInvoicePage,
                                arguments: {"state": 1});
                            break;
                          case 2:
                            estimateController.onChangeCurrentItem(item);
                            Get.toNamed(AppRoute.addItemInvoicePage,
                                arguments: {"state": 2});
                            break;
                          default:
                            itemController.onChangeCurrentItem(item);
                            Get.toNamed(AppRoute.editItemScreen);
                            break;
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name : ${item.name}"),
                            SizedBox(height: 5,),
                            Text("Price : ${item.price}"),
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
