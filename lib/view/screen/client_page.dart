import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/item.dart';
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
  late TextEditingController searchController ;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _loadClients();
  }
  @override
  dispose(){
    super.dispose();
    searchController.dispose();
  }
  
  Future<void> _loadClients() async {
    Future.delayed(Duration.zero, () {
      final items = BusinessController().getAllItems("client");
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
              Get.back();
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
            Get.toNamed(AppRoute.newClientScreen);
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
          SizedBox(height: 10,),
          SearchWidget(controller: searchController),
          SizedBox(height: 15,),
          Visibility(
            visible: mainController.filteredItems.isNotEmpty,
            replacement: Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(flex: 2,),
                    const Icon(
                      Icons.edit_document,
                      size: 40,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Start by adding an client",
                        style: Theme.of(context).textTheme.bodyMedium!),
                        Spacer(),
                  ],
                ),
            ),
            child: Expanded(
              child: ListView.builder(
                  itemCount: mainController.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = mainController.filteredItems[index];
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
                          Text(item.name),
                          const Spacer(),
                          Text(item.price.toString()),
                        ],
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
