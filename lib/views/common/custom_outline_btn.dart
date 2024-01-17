import 'package:flutter/material.dart';
import 'package:job_marketplace/views/common/exports.dart';

class CustomOutlineBtn extends StatelessWidget {
  const CustomOutlineBtn(
      {super.key,
      this.width,
      this.height,
      required this.text,
      this.onPressed,
      required this.color,
      this.color2});

  final double? width;
  final double? height;
  final String text;
  final void Function()? onPressed;
  final Color color;
  final Color? color2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color2,
            border: Border.all(
              width: 1,
              color: color,
            )),
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(
              16,
              color,
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
