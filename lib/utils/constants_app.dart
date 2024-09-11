// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:quick_invoice/model/icon_parameters.dart';
import 'package:quick_invoice/utils/route_app.dart';

class AppConstant {
    // Light Theme Colors
  static const Color lightPrimary = Color.fromARGB(255, 255, 255, 255); // White
  static const Color lightAccent = Color.fromARGB(255, 0, 51, 102);     // Navy Blue (RGB: 0, 51, 102)
  static const Color lightSecondary = Color.fromARGB(255, 176, 196, 222); // Grayish Blue (RGB: 176, 196, 222)
  static const Color lightText = Color.fromARGB(255, 0, 0, 0);           // Black

  // Dark Theme Colors
  static const Color darkPrimary = Color.fromARGB(255, 0, 0, 0);         // Black
  static const Color darkAccent = Color.fromARGB(255, 176, 196, 222);   // Grayish Blue (RGB: 176, 196, 222)
  static const Color darkSecondary = Color.fromARGB(255, 0, 51, 102);    // Navy Blue (RGB: 0, 51, 102)
  static const Color darkText = Color.fromARGB(255, 255, 255, 255); 

  static List<IconParameters> iconsParameters1 = [
    IconParameters(
        icon: Icons.domain,
        name: "Manage business",
        path: AppRoute.businessScreen),
    IconParameters(
        icon: Icons.group, name: "Clients", path: AppRoute.clientScreen),
    IconParameters(
        icon: Icons.import_contacts, name: "Items", path: AppRoute.itemsScreen),
  ];
  static List<IconParameters> iconsParameters2 = [
    IconParameters(
        icon: Icons.format_shapes,
        name: "Invoice style",
        path: AppRoute.invoiceScreen),
    IconParameters(
        icon: Icons.format_shapes_rounded,
        name: "Estimate style",
        path: AppRoute.estimateScreen),
  ];
  static List<IconParameters> iconsInfo = [
    IconParameters(
        icon: Icons.email,
        name: "Talk with developper",
        path: AppRoute.homeScreen),
    IconParameters(
        icon: Icons.rate_review,
        name: "Rate the app",
        path: AppRoute.homeScreen),
  ];

  static double getHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
}
