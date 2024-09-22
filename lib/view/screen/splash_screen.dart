import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quick_invoice/controller/business_controller.dart';
import 'package:quick_invoice/controller/main_controller.dart';
import 'package:quick_invoice/model/business.dart';
import 'package:quick_invoice/utils/constants_app.dart';
import 'package:quick_invoice/utils/route_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      var business = BusinessController().getItem("business", "me");
    if(business == null){
      Get.offAllNamed(AppRoute.introScreen);
    }else{
      final MainController mainController = Get.find<MainController>();
      Business business = Business.fromMap(Map<String, dynamic>.from(
          await BusinessController().getItem("business", "me")));
      mainController.onChange(business.name);
      Get.offAllNamed(AppRoute.homeScreen);
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: AppConstant.getHeight(context),
        width: AppConstant.getWidth(context),
        child: Column(
          children: [
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
              ),
              width: AppConstant.getWidth(context)*0.5,
              height: AppConstant.getHeight(context)*0.5,
              child: SvgPicture.asset("assets/leading.svg")),
            SizedBox(height: 20,),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(color: Colors.black,)),
              Spacer(),
          ],
        ),
      ),
    );
  }
}
