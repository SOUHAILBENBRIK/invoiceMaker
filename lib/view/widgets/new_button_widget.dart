import 'package:flutter/material.dart';
import 'package:quick_invoice/utils/constants_app.dart';

class NewButtonWidget extends StatelessWidget {
  const NewButtonWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.icon});
  final String title;
  final VoidCallback onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black87, fontSize: 15),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              width: AppConstant.getWidth(context) * 0.9,
              height: AppConstant.getHeight(context) * 0.09,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  margin: EdgeInsets.only(
                      left: AppConstant.getWidth(context) * 0.05),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(18)),
                  width: AppConstant.getWidth(context) * 0.3,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Add $title",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13)),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
