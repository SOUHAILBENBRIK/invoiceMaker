import 'package:flutter/material.dart';
import 'package:quick_invoice/utils/constants_app.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.bg,
      required this.textColor});
  final String title;
  final VoidCallback onPressed;
  final Color bg;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: AppConstant.getWidth(context) * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: 14),
        )),
      ),
    );
  }
}
