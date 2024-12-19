import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardTagWidget extends StatelessWidget {
  const CardTagWidget({
    super.key,
    required this.text,
    required this.color,
    this.isLast,
    this.fontSize,
    this.isArAvailable,
  });

  final String text;
  final Color color;
  final bool? isLast;
  final double? fontSize;
  final bool? isArAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      margin:
          isArAvailable == true ? EdgeInsets.only(right: 4.w) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: isLast == true ? 8 : fontSize ?? 10,
        ),
      ),
    );
  }
}
