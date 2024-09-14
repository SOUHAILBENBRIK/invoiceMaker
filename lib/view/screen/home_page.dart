import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';
import 'package:quick_invoice/utils/theme_app.dart';
import 'package:quick_invoice/view/screen/estimate_page.dart';
import 'package:quick_invoice/view/screen/invoice_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void switchToTab(int index) {
    tabController?.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.put(MainController());
    List<Widget> widgets = [const InvoiceScreen(), const EstimateScreen()];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size(AppConstant.getWidth(context),
                AppConstant.getHeight(context) * 0.12),
            child: Column(
              children: [
                Text("Statement", style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: 10,
                ),
                TabBar(
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  controller: tabController,
                  dividerColor: AppTheme.darkAccent,
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  tabs: const [
                    Tab(text: 'Invoices'),
                    Tab(text: 'Estimates'),
                  ],
                  onTap: (index) {
                    switchToTab(index);
                    controller.onChnageIndex(index);
                  },
                ),
              ],
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.info,
            ),
            onPressed: () => debugPrint("hi"),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(AppRoute.settingsScreen);
                },
                icon: const Icon(
                  Icons.settings_outlined,
                ))
          ],
        ),
        body: Obx(
          () => widgets[controller.homeIndex.value],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            if (controller.homeIndex.value == 0) {
              Get.toNamed(AppRoute.newInvoiceScreen);
            } else {
              Get.toNamed(AppRoute.newEstimateScreen);
            }
          },
        ),
      ),
    );
  }
}
