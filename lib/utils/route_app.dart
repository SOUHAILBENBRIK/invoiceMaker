import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quick_invoice/view/screen/add_item_invoice_page.dart';
import 'package:quick_invoice/view/screen/client_page.dart';
import 'package:quick_invoice/view/screen/currencies_page.dart';
import 'package:quick_invoice/view/screen/edit_client_page.dart';
import 'package:quick_invoice/view/screen/edit_item_page.dart';
import 'package:quick_invoice/view/screen/estimate_page.dart';
import 'package:quick_invoice/view/screen/home_page.dart';
import 'package:quick_invoice/view/screen/intro_page.dart';
import 'package:quick_invoice/view/screen/invoice_page.dart';
import 'package:quick_invoice/view/screen/items_page.dart';
import 'package:quick_invoice/view/screen/manage_business.dart';
import 'package:quick_invoice/view/screen/new_client_page.dart';
import 'package:quick_invoice/view/screen/new_estimate_page.dart';
import 'package:quick_invoice/view/screen/new_invoice_page.dart';
import 'package:quick_invoice/view/screen/new_item_page.dart';
import 'package:quick_invoice/view/screen/settings_page.dart';
import 'package:quick_invoice/view/screen/splash_screen.dart';

class AppRoute {
  static String introScreen = "/intro";
  static String splashScreen = "/splash";
  static String homeScreen = "/home";
  static String newInvoiceScreen = "/newInvoice";
  static String settingsScreen = "/settings";
  static String clientScreen = "/client";
  static String newClientScreen = "/newClient";
  static String itemsScreen = "/items";
  static String newItemScreen = "/newItems";
  static String businessScreen = "/business";
  static String estimateScreen = "/estimate";
  static String newEstimateScreen = "/newEstimate";
  static String invoiceScreen = "/invoice";
  static String currenciesScreen = "/currencies";
  static String editClientScreen = "/editClient";
  static String editItemScreen = "/editScreen";
  static String addItemInvoicePage = "/addItemInvoicePage";

  static List<GetPage> routes = [
    GetPage(name: introScreen, page: () => const IntroScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: newInvoiceScreen, page: () => const NewInvoiceScreen()),
    GetPage(name: clientScreen, page: () => const ClientScreen()),
    GetPage(name: newClientScreen, page: () => const NewClientScreen()),
    GetPage(name: itemsScreen, page: () => const ItemScreen()),
    GetPage(name: newItemScreen, page: () => const NewItemScreen()),
    GetPage(name: businessScreen, page: () => const ManageBusinessScreen()),
    GetPage(name: estimateScreen, page: () => const EstimateScreen()),
    GetPage(name: newEstimateScreen, page: () => const NewEstimateScreen()),
    GetPage(name: invoiceScreen, page: () => const InvoiceScreen()),
    GetPage(name: currenciesScreen, page: () => const CurrenciesPage()),
    GetPage(name: settingsScreen, page: () => const SettingsScreen()),
    GetPage(name: editClientScreen, page: () => const EditClientScreen()),
    GetPage(name: editItemScreen, page: () => const EditItemScreen()),
    GetPage(name: addItemInvoicePage, page: () => const AddItemInvoicePage()),
  ];
}
