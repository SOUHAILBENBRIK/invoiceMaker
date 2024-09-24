import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/business_controller.dart';

import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/estimate.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/widgets/search_widget.dart';

class EstimateScreen extends StatefulWidget {
  const EstimateScreen({super.key});

  @override
  State<EstimateScreen> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends State<EstimateScreen> {
  late TextEditingController searchController;
  List list = [];
  final MainController mainController = Get.find<MainController>();
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _loadEstimates();
  }

  @override
  dispose() {
    super.dispose();
    mainController.resetSearch();
    searchController.dispose();
  }

  Future<void> _loadEstimates() async {
    Future.delayed(Duration.zero, () {
      final estimates = BusinessController().getAllItems("estimate");
      mainController.changeEstimate(
        estimates.map((estimate) {
          return EstimateModel.fromMap(Map<String, dynamic>.from(estimate));
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
              visible: mainController.estimates.isNotEmpty,
              replacement: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_document,
                      size: AppConstant.getWidth(context) * 0.15,
                      color: Colors.grey),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Start by Creating new Estimate",
                      style: Theme.of(context).textTheme.bodyMedium!),
                ],
              ),
              child: _listEstimate(context),
            );
          })),
    );
  }

  Widget _listEstimate(BuildContext context) {
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
            visible: mainController.filteredEstimate.isNotEmpty,
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
                  Text("Start by Creating new Estimate",
                      style: Theme.of(context).textTheme.bodyMedium!),
                  const Spacer(),
                ],
              ),
            ),
            child: Expanded(
              child: ListView.builder(
                  itemCount: mainController.filteredEstimate.length,
                  itemBuilder: (context, index) {
                    final EstimateModel item = mainController.filteredEstimate[index];
                    return GestureDetector(
                      onTap: () {},
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
                                Text("Name : ${item.estimateNumber}"),
                                const Spacer(),
                                Text("Total : ${item.total}"),
                              ],
                            ),
                            Row(
                              children: [
                                
                                Text(item.estimateDate.split("T")[0])
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
