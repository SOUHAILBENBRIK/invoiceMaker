// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quick_invoice/model/icon_parameters.dart';
import 'package:quick_invoice/utils/route_app.dart';

class AppConstant {
 
  static String generateRandomId(int length) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join('');
}
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
